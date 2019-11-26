import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_three/models/top.dart';
import 'package:top_three/models/user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });
  
  // collection reference
  final CollectionReference movieCollection = Firestore.instance.collection('movies');

  Future updateUserData(String one, String two, String three) async {
    return await movieCollection.document(uid).setData({
      'one': one,
      'two': two,
      'three': three,
    });
  }

  // brewlist from snapshot
  List<Top> _brewListFromSnapshort(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Top(
        one: doc.data['one'] ?? '',
        two: doc.data['two'] ?? '',
        three: doc.data['three'] ?? '', 
      );
    }).toList();
  }

  // userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
      return UserData(
        uid: uid,
        one: snapshot.data['one'],
        two: snapshot.data['two'],
        three: snapshot.data['three'],
      );
  }

  // get brews stream
  Stream<List<Top>> get brews {
    return movieCollection.snapshots()
      .map(_brewListFromSnapshort);
  }

  // get user doc stream
  Stream<UserData > get userData {
    return movieCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}