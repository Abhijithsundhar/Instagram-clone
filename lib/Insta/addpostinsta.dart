import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstui/Shared.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase_constants.dart';
import '../homePage.dart';
import '../models/postModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}
var url;
class _AddpostState extends State<Addpost> {
   Uint8List? _image;
   Future<Uint8List?> pickImage(ImageSource source) async {
     ImagePicker _imagePicker = ImagePicker();
     XFile? _file = await _imagePicker.pickImage(source: source);
     if (_file != null) {
       return await _file.readAsBytes();
     }
     print('Image not selected');
   }
  /// open image
   Future<void> selectImage() async {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           content: SingleChildScrollView(
             child: ListBody(
               children: <Widget>[
                 GestureDetector(
                   child: ListTile(
                     title: Text("Choose from library"),
                     leading: Icon(Icons.broken_image_outlined),
                   ),
                   onTap: () async {
                     Uint8List? img = await pickImage(ImageSource.gallery);
                     if (img != null) {
                       setState(() {
                         _image = img;
                         Navigator.pop(context);
                       });
                     }
                     else {
                       print("No image selected");
                     }
                   },
                 ),
                 Padding(padding: EdgeInsets.all(8.0)),
                 GestureDetector(
                   child: ListTile(
                     title: Text('Take photo'),
                     leading: Icon(Icons.camera_alt),
                   ),
                   onTap: () async {
                     Uint8List? img = await pickImage(ImageSource.camera);
                     if (img != null) {
                       setState(() {
                         _image = img;
                         Navigator.pop(context);
                       });
                       String imagePath = 'post /';
                       firebase_storage.Reference
                       ref = firebase_storage.FirebaseStorage.instance
                           .ref(imagePath);
                       await ref.putData(_image!).whenComplete(() async {
                         /// imagende url
                         url = await ref.getDownloadURL();
                         PostModels postObject=PostModels(
                             id:myid,
                             post: url,
                             likes: [],
                             postId: '',
                             uploadTime: Timestamp.now(),
                             description: ''
                                  );
                         FirebaseFirestore.instance.collection(FirebaseCollections.usersCollection)
                             .doc(myid).collection(FirebaseCollections.usersPost)
                             .add(postObject.toMap())
                             .then((value)
                         async {
                               print(value);
                            postModel= await auth.getPost(value.id);
                                  var instaPost = postModel!.copyWith(
                                      postId: value.id);
                                  await FirebaseFirestore.instance
                                      .collection(
                                      FirebaseCollections.usersCollection)
                                      .doc(myid)
                                      .collection(FirebaseCollections.usersPost)
                                      .doc(value.id)
                                      .update(instaPost.toMap());
                         });
                       });
                     } else {
                       print("No image selected");
                     }
                   },
                 ),
               ],
             ),
           ),
         );
       },
     );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20,),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.02,),
                  InkWell(
                    onTap: selectImage,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.01,),
                ],
              ),
            ),
            SizedBox(height: height * 0.05,),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
