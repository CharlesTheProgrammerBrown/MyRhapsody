import 'package:MyRhapsody/repositories/models/DistributionModel/distributionModel.dart';

abstract class UserDataRepository {
 Future<void> addDistributionData(DistributionModel distributionData);
}