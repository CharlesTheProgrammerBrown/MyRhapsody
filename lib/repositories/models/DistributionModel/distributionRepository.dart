import 'package:MyRhapsody/repositories/models/DistributionModel/distributionModel.dart';

abstract class DistributionRepository {
 Future<void> addDistributionData(DistributionModel distributionData);
}