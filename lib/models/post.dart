import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String description;
  final String uid;
  final int commentLenght;
  final String classId;
  final String className;
  final String userName;
  final DateTime datePublished;
  final String postImageUrl;
  final String userPhotoURL;

  const PostModel(
      {
        required this.commentLenght,
        required this.classId,
        required this.className,
        required this.postId,
        required this.description,
        required this.uid,
        required this.userName,
        required this.datePublished,
        required this.postImageUrl,
        required this.userPhotoURL,
      });

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
        commentLenght: snapshot["commentLenght"],
        classId: snapshot["classId"],
        className: snapshot["className"],
        uid: snapshot["uid"],
        description: snapshot["description"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"].toDate(),
        userName: snapshot["userName"],
        postImageUrl: snapshot['postImageUrl'],
        userPhotoURL: snapshot['userPhotoURL']
    );
  }

  Map<String, dynamic> toJson() => {
    "classId": classId,
    "className": className,
    "uid": uid,
    "commentLenght": commentLenght,
    "description": description,
    "userName": userName,
    "postId": postId,
    "datePublished": datePublished,
    'postImageUrl': postImageUrl,
    'userPhotoURL': userPhotoURL
  };
}
