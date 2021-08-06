import 'package:MyRhapsody/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserDataRepository.dart';
import 'userDataModel.dart';

class FirebaseUserDataRepository implements UserDataRepository {
  final AuthService _authService = AuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

//helper function to reference userdata collection
  Future<CollectionReference> getCollection() async {
    return FirebaseFirestore.instance.collection('UserCollection');
  }

  @override
  Future<String> addUserData(UserDataModel userData) async {
    final collection = await getCollection();
    final String userId = _authService.getCurrentUser();

    await collection.doc(userId).set(userData.userDataToEntity().toDocument());
    return userId;
  }
}
