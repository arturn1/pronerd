import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String description;
  final String uid;
  final String userName;
  final String userPhotoURL;
  final DateTime datePublished;
  final String postId;



  const CommentModel(
      {required this.description,
        required this.uid,
        required this.userName,
        required this.commentId,
        required this.datePublished,
        required this.userPhotoURL,
        required this.postId,

      });

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
        commentId: snapshot["commentId"],
        description: snapshot["description"],
        uid: snapshot["uid"],
        userName: snapshot["userName"],
        userPhotoURL: snapshot['userPhotoURL'],
        datePublished: snapshot["datePublished"].toDate(),
        postId: snapshot["postId"]
    );
  }

  Map<String, dynamic> toJson() => {
    'commentId': commentId,
    "description": description,
    "uid": uid,
    "username": userName,
    "postId": postId,
    "datePublished": datePublished,
    'postUrl': userPhotoURL,
  };
}
