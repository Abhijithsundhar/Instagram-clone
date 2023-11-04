// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firstui/homePage.dart';
// import 'package:firstui/models/commentModels.dart';
//
// import '../firebase_constants.dart';
//
// class Strams{
//   Stream<List<CommentModels>> comments() {
//     return FirebaseFirestore.instance
//         .collection(FirebaseCollections.usersCollection)
//         .doc(allposts.id)
//         .collection(Post.usersPost)
//         .doc(data[index].postId)
//         .collection(Comment.usersComment)
//         .snapshots()
//         .map((event) => event.docs
//     .map((e) => commentModel.fromMap(e.data()),).)
//
//   }
// }