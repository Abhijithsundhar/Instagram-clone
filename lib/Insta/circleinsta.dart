import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/Insta/addpostinsta.dart';
import 'package:firstui/Insta/followinginsta.dart';
import 'package:firstui/Insta/usersinsta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Shared.dart';
import '../editprofile.dart';
import '../firebase_constants.dart';
import '../homePage.dart';
import '../models/postModel.dart';
import '../models/usersModel.dart';
import 'followersinsta.dart';
var myid=FirebaseAuth.instance.currentUser!.uid;
class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {


// getUser(){
//   FirebaseFirestore.instance.collection(FirebaseCollections.usersCollection).doc(myid).snapshots().listen((event) {
//     model = UsersModel.fromMap(event.data()!);
//
//   });
//
//
//
//
// }


  int allfollowingflength=0;
  getfollowing() async {
    var myfolloowing= await FirebaseFirestore.instance
    .collection(FirebaseCollections.usersCollection)
    .where('followers',arrayContains: myid);
    AggregateQuerySnapshot followingLength=await myfolloowing.count().get();
    allfollowingflength = followingLength.count;
    setState(() {

    });
  }
  int allmyposts=0;
  getPosts() async {
    var myPosts= await FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .doc(myid).collection('posts');
    AggregateQuerySnapshot postslength=await myPosts.count().get();
    allmyposts= postslength.count;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
    getfollowing();
    auth.getUserModel();
  }
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
  Stream<List<PostModels>> userPost() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .doc(myid).collection(FirebaseCollections.usersPost)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) =>  PostModels.fromMap(doc.data()),)
        .toList());
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(height*(0.10)),
          child: Row(children: [
            SizedBox(width: width*(0.02)),
            Text(model!.name!,
              style: GoogleFonts.lobster(
                fontSize: 20
            ),),
            SizedBox(width: width*(0.01),),
            Icon(CupertinoIcons.checkmark_seal_fill,
              color: Colors.blue,
              size: 15,),
            Spacer(),
            InkWell(onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  usersInsta()),),
                child: Icon(Icons.people_outline)),
            SizedBox(width: width*(0.02)),
            InkWell(onTap: () =>  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Addpost()),),
                child: Icon(Icons.add_box_outlined)),
            SizedBox(width: width*(0.02)),
            Icon(Icons.menu),
            SizedBox(width: width*(0.02)),
          ],),
        ),
        body: Column(
          children: [
            SizedBox(height:height*(0.02)),
            Row(
              children: [
                SizedBox(width: width*(0.05)),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(model!.profile!),
                      radius: 35,
                    )
                  ],
                ),
                SizedBox(width: width*(0.2)),
                Column(
                  children: [
                    Text(allmyposts.toString()),
                    Text('posts'),
                  ],
                ),
                SizedBox(width: width*(0.1)),
                InkWell(
                  onTap:() => {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  FollowersInsta()),)
                  },
                  child: Column(
                    children: [
                      Text(model!.followers.length.toString()),
                      Text('followers'),
                    ],
                  ),
                ),
                SizedBox(width: width*(0.1)),
                InkWell(onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  FollowingInsta()),)
                },
                  child: Column(
                    children: [
                      Text(allfollowingflength.toString()),
                      Text('following'),
                    ],
                  ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.only(right:width*(0.6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model!.name!),
                  Text('----------------'),
                  Text('biiiiiiiiiiiooooooooooo'),
                ],
              ),
            ),
            SizedBox(
              width: width*(0.96),
              child: Container(
                color: Colors.black12,
                height: height*(0.07),
                width: width,
                child: Center(
                    child: Text('Dashboard')),
              ),
            ),
            SizedBox(height: height*(0.02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              InkWell(
                onTap: ()=>{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Editprofile()),)
                },
                child: Container(
                    color:Colors.black26,
                  width: width*(0.4),
                  height: height*(0.04),
                  child: Center(
                      child: Text('Edit Profile')),
                ),
              ),
              SizedBox(width: width*(0.03),),
              Container(
                  color:Colors.black26,
                width: width*(0.4),
                height: height*(0.04),
                child: Center(
                    child: Text('Share Profile')),
              ),
            ],),
            SizedBox(height: height*(0.02),),
            Expanded(
              child: Container(
                height: height*(0.5),
                child: Column(
                  children: [
                    TabBar(tabs:[
                      Tab(child:
                      Icon(Icons.image_outlined,
                          color: Colors.black),
                      ),
                      Tab(child:
                      Icon(Icons.perm_contact_cal_outlined,
                        color: Colors.black,),),
                    ] ), Expanded(
      child: TabBarView(
        children: [
        StreamBuilder(
          stream: userPost(),
          builder: (context, snapshot) {
                if (snapshot.hasData) {
                var data = snapshot.data;
            return Container(
            height: height * 0.6,
            width: width,
            child: GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.9) ,
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Container(
                 child: Image.network(data[index].post.toString()),
                );
              },),

      );
          }
                return Container();
          }

        ),
          Container(
            height: height * 0.6,
            width: width,
            child:GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.9) ,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.pink,
                );
              },),
          ),
                ]),
              ),
            ]
            ),
      ),
      ),
    ])));
  }
}
