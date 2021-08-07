import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyModel.dart';

abstract class RhapsodyRepository {
  Stream<List<RhapsodyModel>> getRhapsodyList();
}
