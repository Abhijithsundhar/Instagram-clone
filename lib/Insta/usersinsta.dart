import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Authentication.dart';
import '../Shared.dart';
import '../firebase_constants.dart';
import '../homePage.dart';
import '../models/usersModel.dart';
///login cheytha aale id
var myid=FirebaseAuth.instance.currentUser!.uid;
class usersInsta extends StatefulWidget {
  const usersInsta({super.key});

  @override
  State<usersInsta> createState() => _usersInstaState();
}

class _usersInstaState extends State<usersInsta> {
  // bool loading=true;
  // Future<void> profilemy() async {
  //   // while(myid==null){
  //   //   await Future.delayed(Duration(seconds: 1));
  //   // }
  //   FirebaseFirestore.instance
  //       .collection(FirebaseCollections.usersCollection)
  //       .doc(myid)
  //       .get().then((value) {
  //     model = usersModel.fromMap(value.data()!);
  //     // loading=false;
  //     if(mounted)
  //     {
  //       setState(() {});
  //     }
  //
  //   });
  // }
  Firebase Authentication=Firebase();
  final a = FirebaseFirestore.instance;
  ///streamfunction
  Stream<List<UsersModel>> user() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .where('id',isNotEqualTo: myid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => UsersModel.fromMap(doc.data()),).toList());
  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
        child: Scaffold(
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(height*(0.10)),
            child: Row(children: [
              InkWell(
                  onTap: () => Navigator.pop(
                      context),
                  child: Icon(
                      Icons.arrow_back_ios)),
              SizedBox(width: width*(0.02)),
              Text('users',style: GoogleFonts.lobster(
                  fontSize: 25
              ),),
            ],),
          ),
          body: Column(
            children: [
              StreamBuilder(
                stream: user(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return Expanded(
                      child: Container(
                        height: height * (0.8),
                        child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  width * (0.02),
                                  height * (0.02),
                                  width * (0.02), 0),
                              child: Container(
                                height: height * (0.13),
                                child: Row(
                                  children: [
                                    SizedBox(width: width * (0.03),),
                                    CircleAvatar(
                                      backgroundImage:
                                      NetworkImage(data[index].profile.toString()),
                                      radius: 40,
                                    ),
                                    SizedBox(width: width * (0.05)),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(data[index].name.toString(),
                                            style: TextStyle(
                                            fontWeight: FontWeight.w500
                                        )),
                                        SizedBox(height: height * (0.01),),
                                        Text(data[index].email.toString()),
                                      ],
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10)),
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800)),
                                        onPressed: () {
                                          if(data[index].followers.contains(myid)){
                                            // model = auth.finduser(myid);
                                            data[index].reference!.update({'followers':FieldValue.arrayRemove([myid])});
                                            ///reference ilik document full eduth vech.....^ mele
                                            // FirebaseFirestore.instance.collection( FirebaseCollections.usersCollection)
                                            //     .doc(data[index].id).update(
                                            //     {'followers':FieldValue.arrayRemove([myid])});
                                          }
                                          else{
                                            data[index].reference!.update({'followers':FieldValue.arrayUnion([myid])});
                                          }
                                        },
                                        child: Text(data[index].followers.contains(myid)?"unfollow":'follow'),
                                    ),
                                    SizedBox(width: width * (0.02),)
                                  ],
                                ),
                              ),
                            );
                          },),
                      ),
                    );
                  }else{
                    return Container();
                  }
                },)
            ],
          ),
        )
    );
  }
}