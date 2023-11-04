
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstui/customwidget/story.dart';
import 'package:firstui/homePage.dart';
import 'package:firstui/models/commentModels.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import '../Shared.dart';
import '../firebase_constants.dart';
import '../models/postModel.dart';
import '../models/usersModel.dart';

class Instahome extends StatefulWidget {
  const Instahome({super.key});

  @override
  State<Instahome> createState() => _InstahomeState();
}
class _InstahomeState extends State<Instahome> {
  // bool loading =true;
  // Future<void> profilemy() async {
  //   while(myid==null){
  //     await Future.delayed(Duration(microseconds: 1));
  //   }
  //   FirebaseFirestore.instance
  //       .collection(FirebaseCollections.usersCollection)
  //       .doc(myid)
  //       .get().then((value) {
  //     model = usersModel.fromMap(value.data()!);
  //     loading=false;
  //     if(mounted)
  //     {
  //       setState(() {});
  //     }
  //   });
  // }


  userpro(){
      FirebaseFirestore.instance
          .collection(FirebaseCollections.usersCollection)
          .doc(myid)
          .snapshots().listen((value) {
            model=UsersModel.fromMap(value.data()!);
            if(mounted){
              setState(() {
                     //cvbnm
              });
            }
      });
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // profilemy();
    userpro();
    auth.getUserModel();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userpro();
  }


  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
   TextEditingController comment=TextEditingController();
    return
    //   loading?Scaffold(body:
    // Center(child: CircularProgressIndicator(),),):
    SafeArea(
        child: Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(height*(0.10)),
        child: Row(children: [
          SizedBox(width: width*(0.02)),
          Text('Instagram',style: GoogleFonts.lobster(
            fontSize: 25
          ),),
          Icon(Icons.keyboard_arrow_down_sharp),
          Spacer(),
          Icon(Icons.favorite_border),
          SizedBox(width: width*(0.02)),
          Icon(Icons.send),
          SizedBox(width: width*(0.02)),
        ],),
      ),
      body:
             Column(
               children: [
                 Container(
                   height: 100,
                   child: Row(
                     children: [
                       SizedBox(width: width*(0.02)),
                       SizedBox(width: width*(0.02)),
                       Expanded(
                         child: ListView.separated(
                             itemBuilder: (context, index) => Story(),
                             scrollDirection: Axis.horizontal,
                             // physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             separatorBuilder:(BuildContext context,int index ){
                               return SizedBox(width: 10,);
                             },
                             itemCount: 20),
                       )
                     ],
                   ),
                 ),
              StreamBuilder<List<PostModels>>(
                stream: FirebaseFirestore.instance
                    .collectionGroup(FirebaseCollections.usersPost)
                      .snapshots().map((event) => event.docs
                .map((e) => PostModels.fromMap(e.data())).toList()),
                builder: (context, snapshot) {
                 if(snapshot.hasData){
                   List<PostModels>?data=snapshot.data;
                   return Container(
                     height: height*(0.73),
                     child: ListView.builder(
                         itemCount: data!.length,
                         itemBuilder: (BuildContext context,int index)
                         {
                           return StreamBuilder<UsersModel>(
                             stream: FirebaseFirestore.instance
                               .collection(FirebaseCollections.usersCollection).doc(data[index].id)
                               .snapshots().map((event) => UsersModel.fromMap(event.data()!)),
                             builder: (context, snapshot) {
                               UsersModel? allposts=snapshot.data;
                               return Column(
                                 children: [
                                   Row(
                                     children: [
                                       SizedBox(width: width*(0.02),),
                                       CircleAvatar(
                                         backgroundImage: NetworkImage(allposts?.profile.toString()??''),
                                         radius: 10,
                                       ),
                                       SizedBox(width: width*(0.02),),
                                       Text(allposts?.name ??''),
                                       // Icon(Icons.verified,
                                       //
                                       //   size: 15,
                                       // )
                                     ],
                                   ),
                                   SizedBox(height: height*(0.02),),
                                   Padding(
                                     padding: EdgeInsets.only(bottom: height*(0.02)),
                                     ///photo double tap cheythaal likeee....
                                     child: GestureDetector(
                                       onDoubleTap: () =>
                                       data[index].likes.contains(myid)
                                           ?FirebaseFirestore.instance
                                           .collection(FirebaseCollections.usersCollection)
                                           .doc(allposts?.id)
                                           .collection(FirebaseCollections.usersPost)
                                           .doc(data[index].postId)
                                           .update({
                                         'likes':FieldValue.arrayRemove([myid])
                                       })
                                           :FirebaseFirestore.instance
                                           .collection(FirebaseCollections.usersCollection)
                                           .doc(allposts?.id)
                                           .collection(FirebaseCollections.usersPost)
                                           .doc(data[index].postId)
                                           .update({
                                         'likes':FieldValue.arrayUnion([myid])
                                       }),
                                       child: Container(
                                         child: Image.network(data[index].post.toString()),
                                         height: height*(0.5),
                                       ),
                                     ),
                                   ),
                                   Row(
                                     children: [
                                       SizedBox(width: width*(0.02)),
                                       ///photo like..............
                                       GestureDetector(
                                         onTap: () =>
                                           data[index].likes.contains(myid)
                                               ?FirebaseFirestore.instance
                                               .collection(FirebaseCollections.usersCollection)
                                               .doc(allposts?.id)
                                               .collection(FirebaseCollections.usersPost)
                                               .doc(data[index].postId)
                                               .update({
                                             'likes':FieldValue.arrayRemove([myid])
                                           })
                                               :FirebaseFirestore.instance
                                               .collection(FirebaseCollections.usersCollection)
                                               .doc(allposts?.id)
                                               .collection(FirebaseCollections.usersPost)
                                               .doc(data[index].postId)
                                               .update({
                                             'likes':FieldValue.arrayUnion([myid])
                                           }),
                                           child: data[index].likes.contains(myid)
                                       ? Icon(Icons.favorite,
                                             color: Colors.red,)
                                               :Icon(Icons.favorite_border)),
                                       SizedBox(width: width*(0.02)),
                                       /// comment ....bottom sheet....
                                       GestureDetector(
                                         onTap: () {
                                           showBottomSheet(
                                               // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                                               context: context, builder: (BuildContext context){
                                                 return Container(
                                                   // color: Colors.yellow,
                                                   height: height*.7,
                                                   child: Column(
                                                     children: [
                                                       Text('Comments',
                                                       style: TextStyle(fontSize: 20),),
                                                       Divider(thickness: 1,
                                                         color: Colors.black,
                                                       ),
                                                       Expanded(
                                                         child: StreamBuilder(
                                                           stream: FirebaseFirestore.instance
                                                             .collection(FirebaseCollections.usersCollection)
                                                             .doc(allposts!.id)
                                                             .collection(FirebaseCollections.usersPost)
                                                             .doc(data[index].postId)
                                                             .collection(FirebaseCollections.usersComment)
                                                             .snapshots()
                                                             .map((event) => event.docs
                                                             .map((e) => CommentModels.fromMap(e.data())).toList()),

                                                           builder: (context, snapshot) {
                                                             if(!snapshot.hasData){
                                                               return CircularProgressIndicator();
                                                             }
                                                             List<CommentModels>? usercomment=snapshot.data;
                                                             return Container(
                                                               height: height*(0.65),
                                                               child: ListView.builder(
                                                                 itemCount: usercomment?.length,
                                                                 itemBuilder: (context, index){
                                                                   return StreamBuilder<List<UsersModel>>(
                                                                     stream:
                                                                     FirebaseFirestore.instance
                                                                         .collection(FirebaseCollections.usersCollection)
                                                                       .where('id',isEqualTo: usercomment?[index].id)
                                                                       .snapshots()
                                                                       .map((event) => event.docs
                                                                     .map((e) => UsersModel.fromMap(e.data())).toList()),
                                                                     builder: (context, snapshot) {
                                                                       List<UsersModel>?prodata=snapshot.data;
                                                                       return Container(
                                                                         // color: Colors.red,
                                                                         height: height*(0.10),
                                                                         child: Row(
                                                                           children: [
                                                                             SizedBox(width: width*(0.02),),
                                                                             CircleAvatar(
                                                                               backgroundImage: NetworkImage(prodata?[0].profile??''),
                                                                               radius: 20,
                                                                             ),
                                                                             SizedBox(width: width*(0.02)),
                                                                             Column(
                                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                                               children: [
                                                                                 Text(prodata?[0].name.toString()??''),
                                                                                 Text(usercomment?[index].comment??''),
                                                                                 Text('Reply',style: TextStyle(
                                                                                   fontSize: 10
                                                                                 )),
                                                                               ],
                                                                             ),
                                                                            Spacer(),
                                                                             Icon(Icons.favorite_outline),
                                                                             SizedBox(width: width*(0.02),)
                                                                           ],
                                                                         ),
                                                                       );
                                                                     }
                                                                   );
                                                                 }
                                                               ),
                                                             );
                                                           }
                                                         ),
                                                       ),
                                                       Divider(
                                                         color: Colors.black,
                                                       ),
                                                       Padding(
                                                         padding: MediaQuery.of(context).viewInsets,
                                                         child: Row(
                                                           children: [
                                                             SizedBox(width: width*(0.02)),
                                                             CircleAvatar(
                                                               backgroundImage: NetworkImage(model!.profile.toString()),
                                                               radius: 15,
                                                             ),SizedBox(width: width*(0.01),),
                                                             SizedBox( width: width*(0.8),
                                                               child: TextFormField(
                                                                 controller:  comment,
                                                                 decoration: InputDecoration(
                                                                     border:InputBorder.none ,
                                                                     hintText: 'Add a comment....',
                                                                 ),
                                                               ),
                                                             ),
                                                             GestureDetector(
                                                               onTap: () async {
                                                                    CommentModels commentObeject= CommentModels(
                                                                        comment: comment.text,
                                                                        commentDate: Timestamp.now() ,
                                                                        commentId:'',
                                                                        id: myid );
                                                                    allposts!.reference!.collection(FirebaseCollections.usersPost)
                                                                    .doc(data[index].postId).collection(FirebaseCollections.usersComment)
                                                                        .add(commentObeject.toMap()).then((value) async {
                                                                          print(value);
                                                                          commentModel=await auth.getComment(allposts.id??"", data[index].postId.toString(),
                                                                              value.id);
                                                                          var instaComment=commentModel!.copyWith(commentId: value.id);
                                                                              value.update(instaComment.toMap());
                                                                        });
                                                                    comment.clear();
                                                               },
                                                               child: Text('POST',style: TextStyle(
                                                                   color: Colors.blue,
                                                                   fontWeight: FontWeight.bold,
                                                                   fontSize: 15),),
                                                             )
                                                           ],
                                                         ),
                                                       )
                                                     ],
                                                   ),
                                                 );
                                           });
                                         },
                                           child: Icon(CupertinoIcons.chat_bubble)),
                                       SizedBox(width: width*(0.02)),
                                       Icon(CupertinoIcons.paperplane),
                                       Spacer(),
                                       ///photo save chayyan..............
                                       GestureDetector(
                                         onTap: () {
                                           model!.saved.contains(data[index].postId)
                               ?FirebaseFirestore.instance
                                   .collection(FirebaseCollections.usersCollection)
                                   .doc(myid)
                                   .update({
                               'saved':FieldValue.arrayRemove([data[index].postId])
                               })
                                   :FirebaseFirestore.instance
                                   .collection(FirebaseCollections.usersCollection)
                                   .doc(myid)
                                   .update({
                               'saved':FieldValue.arrayUnion([data[index].postId])
                               });},
                               child: model!.saved.contains(data[index].postId)
                               ? Icon(CupertinoIcons.bookmark_fill,
                                 color: Colors.black,)
                                   :Icon(CupertinoIcons.bookmark)),
                                     ],
                                   ),
                                   ///like count show cheyyaan.........
                                   Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       SizedBox(width: width*(0.015),),
                                       Text('Liked by ${data[index].likes.length.toString()} peoples',
                                         style: TextStyle(fontSize: 12),)
                                     ],
                                   ),
                                   SizedBox(height: height*(0.015),),
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       SizedBox(width: width*(0.015),),
                                       CircleAvatar(
                                         backgroundImage: NetworkImage(model!.profile.toString()),
                                         radius: 9,
                                       ),
                                       SizedBox(width: width*(0.015),),
                                       Text('Add a comment',
                                       style: TextStyle(
                                           fontSize: 15,
                                           color: Colors.black45),
                                           )
                                     ],
                                   ),
                                   SizedBox(height: height*(0.02),)
                                 ],
                               );
                             }
                           );
                         }
                     ),
                   );
                 }
                 else{
                   return Container();
                 }
                }
              ),
               ],
             ),
         ));
  }
}
