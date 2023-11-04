import 'package:cloud_firestore/cloud_firestore.dart';

///modelnde all type
UsersModel? model;

class UsersModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? profile;
  Timestamp? createTime;
  Timestamp? loginTime;
   late List followers;
  late  List following;
  String? password;
  DocumentReference? reference;
  late List saved=[];


  UsersModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.profile,
    required this.createTime,
    required this.loginTime,
    required this.followers,
    required this.following,
    required this.password,
     this.reference,
    required this.saved
  });

  ///to map or to json
  Map<String, dynamic> toMap() {
    final Map<String, dynamic>data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['profile'] = profile;
    data['createTime'] = createTime;
    data['loginTime'] = loginTime;
    data['followers'] =followers;
    data['following'] =following;
    data['password'] = password;
    data['reference'] = reference;
    data['saved'] = saved;
    return data;
  }
  ///from map or from json
  UsersModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    profile = map['profile'];
    createTime = map['createTime'];
    loginTime = map['loginTime'];
    followers = map['followers'];
    following = map['following'];
    password = map['password'];
    reference = map['reference'];
    saved = map['saved'];
  }

  ///copywith
  UsersModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? profile,
    List? follow,
    Timestamp? createTime,
    Timestamp? loginTime,
    List? followers,
    List? following,
    String? password,
    DocumentReference? reference,
    List? saved,

  })=> UsersModel(
      id: id??this.id,
      name: name??this.name,
      phone: phone??this.phone,
      email: email??this.email,
      profile: profile??this.profile,
      createTime: createTime??this.createTime,
      loginTime: loginTime??this.loginTime,
      followers: followers??this.followers,
      following: following??this.following,
      password: password??this.password,
    reference: reference??this.reference,
    saved: saved??this.saved
  );
}


