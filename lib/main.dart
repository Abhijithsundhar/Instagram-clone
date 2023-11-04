import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Insta/instagramUI.dart';
import 'Shared.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAtK_BmTDg6qyJX0rcLFARDakxww3nR6ms",
          authDomain: "adil-26a27.firebaseapp.com",
          projectId: "adil-26a27",
          storageBucket: "adil-26a27.appspot.com",
          messagingSenderId: "299399344807",
          appId: "1:299399344807:web:d151c86bf785ff5beb6182",
          measurementId: "G-HM8GY9XZDP"
      )
    );
  }else{
    await Firebase.initializeApp();
  }

  runApp(const myapp());
}
class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  ///sharedprefernce padikkaan
  // bool as=false;
  // getaa() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //  if(prefs.containsKey('name')){
  //    as=true;
  //  }
  //  else{
  //    as=false;
  //  }
  //  setState(() {
  //
  //  });
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getaa();
  // }

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      ///sharedprefernce padikkaan
      // home:  as==true?Test2():Test1(),
      home: Sharedpre(),
      // home: InstagramUi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//
// const firebaseConfig = {
//   apiKey: "AIzaSyAu-na0sdKj4DvIJ0-vLkE-MYkCQ3nBVeM",
//   authDomain: "abhijith-3f555.firebaseapp.com",
//   projectId: "abhijith-3f555",
//   storageBucket: "abhijith-3f555.appspot.com",
//   messagingSenderId: "659043143580",
//   appId: "1:659043143580:web:fed1c36260e13345828259",
//   measurementId: "G-1TLSLWB9DM"
// };