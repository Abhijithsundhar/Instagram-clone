import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/login.dart';
import 'package:firstui/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication.dart';
import 'Shared.dart';
import 'firebase_constants.dart';
import 'homePage.dart';
import 'models/usersModel.dart';

// var myid=FirebaseAuth.instance.currentUser!.uid;

class Follw extends StatefulWidget {
  const Follw({
    super.key,
  });


  @override
  State<Follw> createState() => _FollwState();
}

final a = FirebaseFirestore.instance;

class _FollwState extends State<Follw> {

  ///serach clear cheyyan
  TextEditingController search=TextEditingController();
  void textFeild(){
    search.clear();
  }
  ///myprofile = login cheytha aale id varan
//   profilemy(){
//     FirebaseFirestore.instance.collection(FirebaseCollections.usersCollection)
//         .doc(myid)
//         .get()
//         .then((value) {
//       setState(() {
//         model=usersModel.fromMap(value.data()!);
//       });
//       if(mounted){
//         setState(() {
//
//         });
//       }
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     profilemy();
//   }
//
//   var uid = FirebaseAuth.instance.currentUser!.uid;
// getCurrentUser()
  ///streamfunction
  Stream<List<UsersModel>> user() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .where('followers',arrayContains: myid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => UsersModel.fromMap(doc.data()),)
        .toList());
  }
  @override
  Widget build(BuildContext context) {

    ///mediaqurey for device sizen anusarich aavaan

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: InkWell(onTap:() =>  Navigator.pop(context,
              MaterialPageRoute(builder: (context)=> HomePage()),),
              child: Icon(Icons.arrow_back_ios)),
          // Builder(
          //     builder: (context) {
          //       return InkWell(onTap: () => Scaffold.of(context).openDrawer(),
          //           child: Icon(Icons.menu_sharp));
          //     }

          title: Text("Following "),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) =>
                    setState(() {
                    }),
                controller: search,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  suffixIcon:InkWell(
                      onTap: () {
                        textFeild();
                        setState(() {
                          Container();
                        });
                      },
                      child: Icon(Icons.clear)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white10)),
                ),
              ),
              SizedBox(
                height: height * (0.05),
              ),
              StreamBuilder(
                  stream: user(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              if (search.text.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Container(
                                    height: height * (0.3),
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: width * (0.02)),
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('${index + 1}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .bold)),
                                              SizedBox(width: width * (0.01)),
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    data[index].profile
                                                        .toString()),
                                                radius: height * (0.07),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * (0.01),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(data[index].name.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: height * (0.02),
                                            ),
                                            Text(data[index].email.toString())
                                          ],
                                        ),
                                        SizedBox(width: width*(0.02),),
                                        // Container(child:
                                        // // ElevatedButton(
                                        // //   child: Text(data[index].followers.contains(myid)?"unfollow":'follow'),
                                        // //   style: ElevatedButton.styleFrom(
                                        // //     primary: Colors.blueGrey,
                                        // //   ),
                                        // //   onPressed: () {
                                        // //     if(data[index].followers.contains(myid)){
                                        // //       FirebaseFirestore.instance.collection( FirebaseCollections.usersCollection)
                                        // //           .doc(data[index].id).update(
                                        // //           {'followers':FieldValue.arrayRemove([myid])});
                                        // //     }
                                        // //     else{
                                        // //       FirebaseFirestore.instance.collection( FirebaseCollections.usersCollection)
                                        // //           .doc(data[index].id).update(
                                        // //           {'followers':FieldValue.arrayUnion([myid])});
                                        // //     }
                                        // //   },
                                        // // ),
                                        // ),
                                        // SizedBox(width: width*(0.02),)
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else if(data[index].name!.toLowerCase().toString().contains(search.text.toLowerCase()))
                              {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Container(
                                    height: height * (0.3),
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: width * (0.03)),
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('${index + 1}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .bold)),
                                              SizedBox(width: width * (0.01)),
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    model!.profile
                                                        .toString()),
                                                radius: height * (0.07),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * (0.01),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(model!.name.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              height: height * (0.02),
                                            ),
                                            Text(model!.email .toString())
                                          ],
                                        ),
                                        SizedBox(width: width*(0.02),),
                                        Container(child:
                                        ElevatedButton(
                                          child: Text('follow'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blueGrey,
                                          ),
                                          onPressed: () {},
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            }
                        ),
                      );
                    } else {
                      return Container(
                        child: Text("//"),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
