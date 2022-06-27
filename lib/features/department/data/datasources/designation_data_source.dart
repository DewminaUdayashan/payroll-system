import '../../domain/entities/designation.dart';
import '../models/designation_model.dart';

abstract class DesignationDataSource {
  Future<List<Designation>> getDesignations({Designation? filter});
  Future<bool> insertDesignation({required DesignationModel designation});
  Future<bool> updateDesignation({required DesignationModel designation});
  Future<bool> deleteDesignation({required Designation designation});
}
