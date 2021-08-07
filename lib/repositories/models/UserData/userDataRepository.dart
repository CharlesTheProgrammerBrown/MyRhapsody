import 'package:MyRhapsody/repositories/models/UserData/userDataModel.dart';

abstract class UserDataRepository {
 Future<void> addUserData(UserDataModel userData);
}