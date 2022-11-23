import 'dart:convert';

import 'package:ac/balance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController t1 = TextEditingController();

  // List<user> u=[];
  List<user> userl = [];
  user? u;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future getdata() async {
    var url = Uri.https('storemydata.000webhostapp.com', 'account_view.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List l = jsonDecode(response.body);
    userl.clear();
    l.forEach((element) {
      u = user.fromJson(element);
      userl.add(user.fromJson(element));
    });
    return userl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: Drawer(),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 50,
          ),
          Icon(Icons.more_vert_rounded)
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<user> l = snapshot.data as List<user>;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  color: Colors.white,
                  child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            "${l[index].name}",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 160,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.note_alt_outlined,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () async {
                                var url = Uri.parse(
                                    'https://storemydata.000webhostapp.com/account_delete.php?id=${l[index].id}');
                                var response = await http.get(url);
                                print(response.body);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return home();
                                  },
                                ));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black12),
                            alignment: Alignment.center,
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Credit(+)",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "₹ 0",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey),
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Debit(-)",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "₹ 0",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return balance(l[index]);
                                      },
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepPurple),
                                    height: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Balance",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "₹ 0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ))),
                        ],
                      )),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Container(
                    width: double.infinity,
                    color: Colors.deepPurple,
                    height: 30,
                    child: Text(
                      "Add new account",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  content: TextField(
                    controller: t1,
                    decoration: InputDecoration(
                        hintText: "Account name",
                        focusColor: Colors.deepPurple),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("cancel")),
                        ),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              border: Border.all(
                                  color: Colors.deepPurple, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                              onPressed: () async {
                                String str1 = t1.text;

                                var url = Uri.parse(
                                    'https://storemydata.000webhostapp.com/account_in.php?name=$str1');
                                var response = await http.get(url);
                                print(
                                    'Response status: ${response.statusCode}');
                                print('Response body: ${response.body}');
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return home();
                                  },
                                ));
                              },
                              child: Text(
                                "save",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.deepPurple,
          child: Icon(
            Icons.add_business,
            size: 20,
            color: Colors.amber,
          )),
    );
  }
}
