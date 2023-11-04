import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/models/usersModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Authentication.dart';
import '../Shared.dart';
import '../firebase_constants.dart';
import 'circleinsta.dart';
import 'homeinsta.dart';
var myid=FirebaseAuth.instance.currentUser!.uid;
class InstagramUi extends StatefulWidget {
  const InstagramUi({super.key});

  @override
  State<InstagramUi> createState() => _InstagramUiState();
}

class _InstagramUiState extends State<InstagramUi> {

  Firebase auth=Firebase();

List insta=[
   Instahome(),
  Container(color: Colors.green),
  Container(color: Colors.black),
  Container(color: Colors.redAccent,),
  Userpage()
];
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // auth.getUserModel();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: insta[_currentIndex],
        ///bottam baaaaaaaaaaaaaaaaaaaaaaar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.videocam),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                // backgroundColor: Colors.cyanAccent,
                backgroundImage: NetworkImage(model?.profile??''),
                radius: 12,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
        );
  }
}
