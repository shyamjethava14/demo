
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';


void main()
{
  runApp(MaterialApp(
    home: splash(),
  ));
}
class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    homepage();
  }
    homepage()
    async {
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return home();
      },));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.account_balance_sharp,size: 100,color: Colors.white,)),
          SizedBox(height: 100,),
          Text("Account Manager",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
        ],
      ),
    );
  }
}
