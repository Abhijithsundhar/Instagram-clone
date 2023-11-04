import 'package:cloud_firestore/cloud_firestore.dart';

///comment modeeeeeeeellll
CommentModels? commentModel;

class CommentModels{
   late String comment;
  Timestamp? commentDate;
  String? commentId;
  String? id;

  CommentModels({
     required this.comment,
    required this.commentDate,
    required this.commentId,
    required this.id
  });
  Map<String,dynamic> toMap() {
    final Map<String,dynamic>data=<String,dynamic> { };
    data['comment']= comment;
    data['commentDate']= commentDate;
    data['commentId']=commentId;
    data['id']=id;
    return data;
  }
  CommentModels.fromMap(Map<String, dynamic> map) {
    comment= map['comment'];
    commentDate=map['commentDate'];
    commentId=map['commentId'];
    id=map['id'];
  }
  CommentModels copyWith({
    String? comment,
    Timestamp? commentDate,
    String? commentId,
    String? id
  })=>CommentModels(
    comment: comment?? this.comment,
    commentDate: commentDate?? this.commentDate,
    commentId: commentId?? this.commentId,
    id: id?? this.id,
  );
}
