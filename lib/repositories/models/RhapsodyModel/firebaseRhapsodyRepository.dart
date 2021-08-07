import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyRepository.dart';
import 'package:MyRhapsody/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'rhapsodyEntity.dart';
import 'rhapsodyModel.dart';

class FirebaseUserCampaignCategoryRepository implements RhapsodyRepository {
  final AuthService _authService = AuthService();
  String currentUserLanguage;

  getRhapsoName() async {
    await FirebaseFirestore.instance
        .collection("UserCollection")
        .doc(_authService.getCurrentUser())
        .get()
        .then((eachDoc) {
      currentUserLanguage = eachDoc.data()["language"];
    });
  }

  Future<CollectionReference> getCollection() async {
    // getRhapsoName();
    final collection = FirebaseFirestore.instance.collection('rhapsodies-alt');
    collection
        .orderBy("createdOn")
        .where("language", isEqualTo: currentUserLanguage);
    return collection;
  }

  @override
  Stream<List<RhapsodyModel>> getRhapsodyList() async* {
    await getRhapsoName();
    final collection = await getCollection();

    // FirebaseStorage.instance.ref().child(image).getDownloadURL()
    yield* collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              RhapsodyModel.fromEntity(RhapsodyEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
