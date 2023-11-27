import 'dart:core';
import 'dart:js';
import 'package:firstui/models/commentModels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'firebase_constants.dart';
import 'homePage.dart';
import 'models/postModel.dart';
import 'models/usersModel.dart';
var usernow;
///Google sign in
class Firebase {
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      final user = UsersModel(
          id: value.user!.uid,
          name: googleUser!.displayName,
          phone: '',
          email: googleUser!.email ,
          profile: googleUser.photoUrl,
          createTime: Timestamp.now(),
          loginTime:Timestamp.now(),
          followers: [],
          following: [],
          password: '',
          saved: []);
      usernow=value.user!.uid;
      if(value.additionalUserInfo?.isNewUser??true) {
        FirebaseFirestore.instance
            .collection(FirebaseCollections.usersCollection)
            .doc(value.user!.uid)
            .set(user.toMap());
      }

      else{
        finduser(usernow);
        SharedPreferences share=await SharedPreferences.getInstance();
        share.setString('id', myid);
        var a=model?.copyWith(
            loginTime: Timestamp.now(),
        reference: usernow);
        FirebaseFirestore.instance.collection(FirebaseCollections.usersCollection)
            .doc(usernow).update(a!.toMap());

        // FirebaseFirestore.instance.collection('settings').doc(
        //     'abhi').update({
        //     'test':FieldValue.increment(1)});
      }

    });
  }

  ///login cheyyaaan
  Login(BuildContext context, _email, _password) {
    // getuser({required String email, required String password}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage())));
  }


  ///sign in cheyyaan

  Signup(BuildContext context, _name, _email, _phone, _password,
      _confirmPassword) {
    // getuser({required String email, required String password}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email.toString(), password: _password.toString())
        .then((value) {
      final _userNow = value.user;
      if (_userNow != null) {
        final signData = UsersModel(
            id: _userNow.uid,
            name: _name.toString(),
            phone: _phone.toString(),
            email: _email.toString(),
            profile: "",
            createTime: Timestamp.now(),
            loginTime: Timestamp.now(),
            followers: [],
            following: [],
            password: _password.toString(),
            saved: []);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      FirebaseFirestore.instance
          .collection(FirebaseCollections.usersCollection)
          .doc(value.user!.uid)
          .set(
        signData.toMap()
      );
    }});
  }
  ///for copywith user nokkan uuuuuuuuusssssseeeeeeeerrrrrrrrr
  finduser(String usernow)async{
    DocumentSnapshot<Map<String,dynamic>>snapshot=await
    FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .doc(usernow)
        .get();
    if(snapshot.exists) {
      model = UsersModel.fromMap(snapshot.data()!);
      return model;
    }

  }
  ///all posts
  getPost(String postId) async {
    DocumentSnapshot<Map<String,dynamic>>snapshot=await
    FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .doc(myid)
        .collection(FirebaseCollections.usersPost)
        .doc(postId)
        .get();
    if(snapshot.exists) {
      var postData = PostModels.fromMap(snapshot.data()!);
      return postData;
    }
    return null;
  }
  ///comment gett
  getComment(String myid , String postId,String commentId)
  async {
    DocumentSnapshot<Map<String,dynamic>>snapshot=(await
    FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
    .doc(myid).collection(FirebaseCollections.usersPost)
    .doc(postId).collection(FirebaseCollections.usersComment).doc(commentId)
    .get());
    if(snapshot.exists){
      var commentData =CommentModels.fromMap(snapshot.data()!);
      return commentData;
    }

  }
 ///model access cheyyan vendiiiiiiiiiiiiiiiiiiiiiii
  getUserModel() async {
    model=( await finduser(FirebaseAuth.instance.currentUser!.uid));
  }

}





