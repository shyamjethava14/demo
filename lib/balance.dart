import 'dart:convert';
// import 'package:ac/model.dart';
import 'package:ac/model.dart';
import 'package:ac/modelin2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class balance extends StatefulWidget {
  user? l;
  balance(this.l);






  @override
  State<balance> createState() => _balanceState();
}

class _balanceState extends State<balance> {
  TextEditingController a=TextEditingController();
  TextEditingController p=TextEditingController();
  String type="";
  List<user2> m=[];
  Future getview()
  async {
    var url = Uri.parse('https://storemydata.000webhostapp.com/accountin2_view.php?id=${widget.l?.id}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List l=jsonDecode(response.body);
    m.clear();
    l.forEach((element) {
      m.add(user2.fromJson(element));
    });
    print(m);
    return m;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        toolbarHeight: 60,
        backgroundColor: Colors.deepPurple,
        title: Text('${widget.l!.name}'),
        actions: [
          Row(
            children: [
              IconButton(onPressed: () {
                showDialog(barrierColor: Colors.transparent,context: context, builder: (context) {
                  return AlertDialog(
                    title: Container(color: Colors.deepPurple,child: Text("Add new account",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),),
                    content: Column(
                      children: [
                        TextField(decoration: InputDecoration(hintText: "29 sep,2022",focusColor: Colors.deepPurple),),
                        Row(
                          children: [
                            Text("Transaction type:"),
                            Expanded(child: Radio(value: "Credit(+)", groupValue: type, onChanged: (value) {
                              setState(() {
                                type=value.toString();

                              });
                            },)),
                            Text("Credit",style: TextStyle(fontSize: 15),),
                            Expanded(child: Radio(value: "Debit(-)", groupValue: type, onChanged: (value) {
                              setState(() {
                                type=value.toString();

                              });
                            },)),
                            Text("Debit",style: TextStyle(fontSize: 15),),


                          ],
                        ),
                        TextField(controller: a,decoration: InputDecoration(hintText: "Amount",focusColor: Colors.deepPurple),),
                        TextField(controller: p,decoration: InputDecoration(hintText: "Particular",focusColor: Colors.deepPurple),),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.deepPurple,width: 2),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text("cancel")),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    border: Border.all(color: Colors.deepPurple,width: 2),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: TextButton(onPressed: () async {
                                  String date="23 sep,2022";
                                  String amount=a.text;
                                  String part=p.text;
                                  String Type=type;
                                  String id="2";

                                  var url = Uri.parse('https://storemydata.000webhostapp.com/accountin2_insert.php?ac_id=$id&date=$date&type=$Type&amount=$amount&particular=$part');
                                  var response = await http.get(url);
                                  print('Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  //   return balance();
                                  // },));

                                }, child: Text("save",style: TextStyle(color: Colors.white),)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                  );
                },);
              }, icon: Icon(Icons.add_business_outlined)),
              Icon(Icons.search_outlined),
              Icon(Icons.more_vert_sharp)
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Date",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
              Text("Particular",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
              Text("Credit(₹)",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
              Text("Debit(₹)",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
            ],
          ),
        FutureBuilder(future: getview(),builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done)
            {
                if(snapshot.hasData)
                  {
                    List<user2> list=snapshot.data;
                    return ListView.builder(itemCount: list.length,itemBuilder: (context, index) {
                    return InkWell(onTap: () {
                     showDialog(context: context, builder: (context) {
                       return SimpleDialog(
                         children: [
                           Column(
                             children: [
                                TextButton(onPressed: () {

                                }, child: Text("Edit")),
                              TextButton(onPressed: () async {
                                var url = Uri.parse('https://storemydata.000webhostapp.com/accountin2_delete.php?id=${list[index].id}');
                                var response = await http.get(url);
                                print(response.body);
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                              }, child: Text("Delete")),
                             ],
                           )
                         ],
                         elevation: 2,
                       );
                     },);
                    },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${list[index].date}'),
                          Text('${list[index].particular}'),
                          Text('${list[index].amount}'),
                          Text('${list[index].type}'),
                        ],
                      ),
                    );
                    },shrinkWrap: true,);
                  }
                else
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }

            }
          else
            {
              return Center(child: CircularProgressIndicator(),);
            }
        },),


        ],
      ),

    );
  }
}
