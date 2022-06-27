import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/usecases/usecase.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';
import 'package:payroll_system/features/department/domain/repositories/designation_repository.dart';

class Designations extends UseCase<List<Designation>, Designation> {
  final DesignationRepository _designationRepository;

  Designations(this._designationRepository);
  @override
  Future<Either<Failure, List<Designation>>> call(Designation params) {
    return _designationRepository.getdesignations();
  }
}
