import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pronerd/models/room.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;
  final List classes;

  const UserModel(
      {this.userName = '',
      this.uid = '',
      this.photoUrl = "https://avatars.githubusercontent.com/u/31557902?v=4",
      this.email = '',
      this.bio = "",
      this.followers = const [],
      this.following = const [],
      this.classes = const []});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        userName: snapshot["userName"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        photoUrl: snapshot["photoUrl"],
        bio: snapshot["bio"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        classes: snapshot["classes"]);
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        "classes": classes
      };
}
