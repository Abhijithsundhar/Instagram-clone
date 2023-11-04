import 'package:firstui/test1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Test2 extends StatefulWidget {
  const Test2({super.key});


  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  String name='';
  getlocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name= prefs.getString('name')!;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocal();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(name),
          ElevatedButton(onPressed:() async {
            // var aa;
            // if(aa.text.isNotEmpty){
            // }
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Test1()),);
          },
              child: Text('clear'))
        ],
      ),
    );
  }
}
