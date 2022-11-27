import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_shots_mobile/models/shots.dart';
import 'package:order_shots_mobile/models/user.dart';

class DataBaseService {
  final String uid;
  // collection reference
  final CollectionReference shotsCollection =
      FirebaseFirestore.instance.collection('Shots');

  DataBaseService({this.uid = ''});

  Future updateUserData(
      String dilutionStrength, String name, int alcoholStrength) async {
    return await shotsCollection.doc(uid).set({
      "dilutionStrength": dilutionStrength,
      "name": name,
      "alcoholStrength": alcoholStrength
    });
  }

  // Shot list from snaphot
  List<Shots>? _shotListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Shots(
          name: doc['name'] ?? '',
          alcoholStrength: doc['alcoholStrength'] ?? 0,
          dilutionStrength: doc['dilutionStrength'] ?? '0');
    }).toList();
  }

  // UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        dilution: snapshot['dilutionStrength'],
        strength: snapshot['alcoholStrength']);
  }

  // Get shots stream
  Stream<List<Shots>?> get shots {
    return shotsCollection.snapshots().map(_shotListFromSnapshot);
  }

  // get User doc stream
  Stream<UserData> get userData {
    return shotsCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
