import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/Insta/instagramUI.dart';
import 'package:firstui/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication.dart';
import 'Shared.dart';
import 'editprofile.dart';
import 'firebase_constants.dart';
import 'followers.dart';
import 'following.dart';
import 'models/usersModel.dart';

Firebase auth=Firebase();
var myid=FirebaseAuth.instance.currentUser!.uid;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

final a = FirebaseFirestore.instance;

class _HomePageState extends State<HomePage> {
///serach clear cheyyan
  TextEditingController search=TextEditingController();
  void textFeild(){
    search.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilemy();
  }
  bool loading =true;
  Future<void> profilemy() async {
    while(myid==null){
      await Future.delayed(Duration(seconds: 1));
    }
    FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .doc(myid)
        .get().then((value) {
      model = UsersModel.fromMap(value.data()!);
      loading=false;
      if(mounted)
      {
        setState(() {});
      }

    });


  }


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
///mediaqurey for device sizen anusarich aavaan

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return loading?Scaffold(body:
    Center(child: CircularProgressIndicator(),),): SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: height*(.2),
                width: width,
                color: Colors.black26,
                // SizedBox(height: height*(0.2)),
               child: Column(
                 children: [
                   ListTile(
                     trailing: InkWell(
                       onTap: () =>  Navigator.push(context,
          MaterialPageRoute(builder: (context)=> Editprofile()),),
                         child: Icon(Icons.edit_outlined)),
                   ),
                   // SizedBox(height: height*(0.03),),
                   // Image.network(model!.profile!),
                   Stack(
                     children: [
                       SizedBox(height: height*(0.01),),
                       Positioned(
                         child: CircleAvatar(backgroundImage:
                         NetworkImage(model!.profile!),radius: 30 ),
                       ),
                     ],
                   ),
                     //  CircleAvatar(backgroundImage:
                     // NetworkImage(model!.profile!)),
                   SizedBox(height: height*(0.01),),
                   Text(model!.name!,
                   // style: TextStyle(fontSize: 18)
                     ),
                 ],
               ),
              ),
              Container(
                height: height*(.8),
                color: Colors.white54,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () =>
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Follwers()),),
                      leading: Icon(Icons.person_outline_rounded),
                      title: Text('followers'),

                    ),
                    ListTile(onTap: () =>
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Follw()),),
                      leading: Icon(Icons.person_outline_rounded),
                      title: Text('following'),
                    ),
                    ListTile(
                      leading: Icon(Icons.post_add),
                    ),
                    ListTile(
                      onTap: () =>  Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>InstagramUi()),),
                      title: Text('INSTAGRAM'),
                    ),
                    SizedBox(height: height * (0.05)),
                    ElevatedButton(
                      ///logout click akkiyaa user remove aavan
                        onPressed:() async {
                          SharedPreferences share= await SharedPreferences.getInstance();
                          share.clear();
                           Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=> Login()), (route) => false);
                        } ,
                        child:Text('LogOut'))
                  ]
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: Builder(
            builder: (context) {
              return InkWell(onTap: () => Scaffold.of(context).openDrawer(),
                  child: Icon(Icons.menu_sharp));
            }
          ),
          title: Text("Firebase Users"),
          actions: [
            // Text('SWITCH TO INSTAGRAM')
          ],
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
                    if(!snapshot.hasData){
                      return Center(child: const CircularProgressIndicator());
                    }else if  ( snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: LinearProgressIndicator());
                    }
                    else  {
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
                                      Container(child:
                                        ElevatedButton(
                                          child: Text(data[index].followers.contains(myid)?"unfollow":'follow'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blueGrey,
                                          ),
                                          onPressed: () {
                                                 if(data[index].followers.contains(myid)){
                                                   model = auth.finduser(myid);
                                                   model!.reference!.update({'followers':FieldValue.arrayRemove([myid])});
                                                   ///reference ilik document full eduth vech.....^ mele
                                                   // FirebaseFirestore.instance.collection( FirebaseCollections.usersCollection)
                                                   //     .doc(data[index].id).update(
                                                   //     {'followers':FieldValue.arrayRemove([myid])});
                                                 }
                                                 else{
                                                   model!.reference!.update({'followers':FieldValue.arrayUnion([myid])});

                                                 }
                                          },
                                        ),
                                      ),
                                      // SizedBox(width: width*(0.02),)
                                    ],
                                  ),
                                ),
                              );
                            }
                            else if(data[index].name!.toLowerCase().toString()
                                .contains(search.text.toLowerCase()))
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
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
