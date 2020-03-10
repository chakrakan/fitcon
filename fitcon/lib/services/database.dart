import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUserData(
      String displayName, String userType, String email) async {
    return await usersCollection.document(uid).setData({
      'displayName': displayName,
      'userType': userType,
      'email': email,
    });
  }
}
