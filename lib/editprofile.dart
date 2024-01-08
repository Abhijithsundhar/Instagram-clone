import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstui/Insta/homeinsta.dart';
import 'package:firstui/addimage.dart';
import 'package:firstui/main.dart';
import 'package:firstui/models/usersModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Shared.dart';
import 'firebase_constants.dart';
import 'homePage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;  


class Editprofile extends StatefulWidget {
  const Editprofile({super.key});
  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final formkey = GlobalKey<FormState>();
  Uint8List? _image;
  var url;
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
                      ///new photo to upload akkan
                      String imagePath = 'profile_images/';
                      firebase_storage.Reference
                      ref = firebase_storage.FirebaseStorage.instance
                          .ref(imagePath);
                      await ref.putData(_image!).whenComplete(() async {
                        /// imagende url
                        url = await ref.getDownloadURL();

                        ///old image maari url ayyi update akkunnu
                        FirebaseFirestore.instance
                            .collection(FirebaseCollections.usersCollection);
                        model = model!.copyWith(profile: url);
                      });
                    } else {
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

                      ///new photo to upload akkan
                      String imagePath = 'profile_images/';
                      firebase_storage.Reference
                      ref = firebase_storage.FirebaseStorage.instance
                          .ref(imagePath);
                      await ref.putData(_image!).whenComplete(() async {
                        /// imagende url
                        url = await ref.getDownloadURL();

                        ///old image maari url ayyi update akkunnu
                        FirebaseFirestore.instance
                            .collection(FirebaseCollections.usersCollection)
                            .doc(myid)
                            .update({'profile': url});
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
  profilemy() {
    FirebaseFirestore.instance
        .collection(FirebaseCollections.usersCollection)
        .doc(myid)
        .get()
        .then((value) {
      model = UsersModel.fromMap(value.data()!);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  TextEditingController name=TextEditingController(text: model?.name);
  TextEditingController phone=TextEditingController(text: model?.phone);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Profile'),
        actions: [
          InkWell(
            onTap: () async {
              if (formkey.currentState!.validate()) {
                model = await auth.finduser(myid);
                var editprofile = model!.copyWith(
                  name: name.text,
                  phone: phone.text,
                  profile: model!.profile,
                );
                model!.reference!.update(editprofile.toMap());
                Navigator.pushAndRemoveUntil(
                  context,
                  // MaterialPageRoute(builder: (context) => HomePage()),
                  MaterialPageRoute(builder: (context) => Instahome()),
                      (route) => false,
                );
              }
            },
            child: Icon(Icons.done),
          ),
          SizedBox(width: width * 0.05)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.02,),
                  Stack(
                      children: [
                        _image != null ?
                        Positioned(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(_image!),
                          ),
                        ) :
                        Positioned(
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage(model!.profile!),
                            radius: 50,
                          ),
                        ),
                        Positioned(
                          child: InkWell(
                            onTap: selectImage,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black,
                            ),
                          ),
                          bottom: 10,
                          right: 0.04,
                        ),
                      ]
                  ),
                  SizedBox(height: height * 0.01,),
                  Text('Edit photo', style: TextStyle(
                    fontSize: 15,
                  )),
                ],
              ),
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    width: width * 0.8,
                    child: TextFormField(
                      onChanged: (name) {},
                      controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter name to change';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: TextFormField(
                      onChanged: (phone) {},
                      controller: phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'type Any number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Number',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.05,),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

