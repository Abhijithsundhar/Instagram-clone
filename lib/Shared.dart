import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/Insta/instagramUI.dart';
import 'package:firstui/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_constants.dart';
import 'homePage.dart';
import 'models/usersModel.dart';
// var myid=FirebaseAuth.instance.currentUser!.uid;
var height;
var width;

class Sharedpre extends StatefulWidget {

  const Sharedpre({super.key,});

  @override
  State<Sharedpre> createState() => _SharedpreState();
}

class _SharedpreState extends State<Sharedpre> {


  ///function for shared preference
  shared() async {
    SharedPreferences.getInstance().then((share) {
      if (share.containsKey('id')) {
        var myid = share.getString('id')!;
        FirebaseFirestore.instance.collection(
            FirebaseCollections.usersCollection)
            .doc(myid).get().then((value) {
          if (value.exists) {
            model = UsersModel.fromMap(value.data()!);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => InstagramUi()), (
                    route) => false);
          }
          else {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => Login()), (
                    route) => false);
          }
          if (mounted) {
            setState(() {

            });
          }
        }
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
    shared();
    });
  }

  //

  //    SharedPreferences.getInstance().then((share) {
  //       if(share.containsKey('uid')){
  //   myid=share.getString('uid')!;
  //   // usernow =share.getString('uid');
  //   Navigator.pushAndRemoveUntil(context,
  //       MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
  //   }
  //       else{

  //       }
  // }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: LinearProgressIndicator(
        ),
      ),
    );
  }
}
