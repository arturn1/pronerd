import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String classId;
  final String name;
  final String uid;
  final String userName;
  final DateTime dateCreated;
  final List followers;

  const RoomModel(
      {required this.classId,
      required this.name,
      required this.uid,
      required this.userName,
      required this.dateCreated,
      required this.followers});

  static RoomModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return RoomModel(
        uid: snapshot["uid"],
        name: snapshot["name"],
        classId: snapshot["classId"],
        dateCreated: snapshot["dateCreated"].toDate(),
        userName: snapshot["userName"],
        followers: snapshot["followers"]);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "userName": userName,
        "classId": classId,
        "dateCreated": dateCreated,
        "followers": followers
      };
}
