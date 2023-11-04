import 'package:cloud_firestore/cloud_firestore.dart';



PostModels? postModel;
class PostModels{
  String? id;
  String? post;
  late List likes=[];
  String? postId;
  Timestamp? uploadTime;
  String? description;


  PostModels({
     this.id,
     this.post,
     required this.likes,
     this.postId,
     this.uploadTime,
     this.description,
  });

  Map<String,dynamic> toMap() {
    final Map<String,dynamic>data=<String,dynamic> { };
    data['id']= id;
    data['post']= post;
    data['likes']= likes;
    data['postId']= postId;
    data['uploadTime']=uploadTime;
    data['description']=description;
    return data;
  }
  PostModels.fromMap(Map<String, dynamic> map) {
    id= map['id'];
    post=map['post'];
    likes=map['likes'];
    postId=map['postId'];
    uploadTime =map['uploadTime'];
    description =map['description'];
  }

  PostModels copyWith({
    String? id,
    String? post,
    List? likes,
    String? postId,
    Timestamp? uploadTime,
    String? description
  })=>PostModels(
      id: id?? this.id,
      post: post?? this.post,
      likes: likes?? this.likes,
      postId: postId?? this.postId,
      uploadTime: uploadTime?? this.uploadTime,
      description:description?? this.description
  );
}