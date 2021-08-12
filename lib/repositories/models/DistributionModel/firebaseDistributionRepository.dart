import 'package:MyRhapsody/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'distributionModel.dart';
import 'distributionRepository.dart';

class FirebaseDistributionRepository implements DistributionRepository {
  final AuthService _authService = AuthService();

//helper function to reference userdata collection
  Future<CollectionReference> getCollection() async {
    return FirebaseFirestore.instance.collection('UserCollection');
  }

  @override
  Future<void> addDistributionData(DistributionModel distributionData) async {
    final collection = await getCollection();
    final String userId = _authService.getCurrentUser();
    // final String userId = userData.id;

    await collection
        .doc(userId)
        .collection("Contacts")
        .doc()
        .set(distributionData.distributionToEntity().toDocument());
    // return userId;
  }
}
