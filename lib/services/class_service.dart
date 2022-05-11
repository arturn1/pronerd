import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pronerd/models/room.dart';
import 'package:pronerd/models/user.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';

abstract class ClassService {
  Future<void> addClassToDB(RoomModel roomModel) async {
    try {
      String classId = const Uuid().v1();
      await firestore.collection('rooms').doc(classId).set({
        'name': roomModel.name,
        'uid': roomModel.uid,
        'userName': roomModel.userName,
        'classId': classId,
        'followers': roomModel.followers,
        'dateCreated': roomModel.dateCreated
      });
      DocumentSnapshot doc =
          await firestore.collection('users').doc(roomModel.uid).get();
      await firestore.collection('users').doc(roomModel.uid).update({
        'classes': FieldValue.arrayUnion([classId]),
      });
    } catch (err) {
      rethrow;
    }
  }

  Stream<List<RoomModel>> getClassStreamFromDB() {
    return firestore.collection("rooms").snapshots().map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<RoomModel>> getClassStreamByUserFromDB(UserModel user) {
    return firestore
        .collection("rooms")
        .where("followers", arrayContains: user.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Future<bool> getUserIsFollowingFromDB(String classId, UserModel? user) async {
    var room = await firestore.collection('rooms').doc(classId).get();

    bool following = room.data()!['followers'].contains(user!.uid);
    return following;
  }

  Future<void> followClassToDB(String classId, UserModel? user) async {
    try {
      await firestore.collection('rooms').doc(classId).update({
        'followers': FieldValue.arrayUnion([user!.uid])
      });

      await firestore.collection('users').doc(user.uid).update({
        'classes': FieldValue.arrayUnion([classId]),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> unfollowClassToDB(String classId, UserModel? user) async {
    try {
      await firestore.collection('rooms').doc(classId).update({
        'followers': FieldValue.arrayRemove([user!.uid])
      });

      await firestore.collection('users').doc(user.uid).update({
        'classes': FieldValue.arrayRemove([classId]),
      });
    } catch (e) {
      rethrow;
    }
  }
}
