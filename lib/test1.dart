import 'package:firstui/test2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  TextEditingController aa=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          TextFormField(
            controller: aa,
          ),
          ElevatedButton(onPressed:() async {
            if(aa.text.isNotEmpty){
            }
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('name', aa.text);
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Test2()));
          },
              child:Text("button")),
        ],
      )

    );
  }
}
