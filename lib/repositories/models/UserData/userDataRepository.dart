import 'package:MyRhapsody/repositories/models/UserData/userDataModel.dart';

abstract class UserDataRepository {
  Future<String> addUserData(UserDataModel userData);
}