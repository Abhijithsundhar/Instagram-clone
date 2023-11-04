import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/main.dart';
import 'package:firstui/sign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Shared.dart';

class Home extends StatefulWidget {

  const Home({super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height:height*.5,
        width:width*.5   ,
        color: Colors.red,
      ),
    );

  }
}



