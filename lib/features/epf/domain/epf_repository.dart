import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/features/epf/data/epf_model.dart';
import 'package:payroll_system/features/epf/domain/epf.dart';

abstract class EPFRepository {
  Future<Either<Failure, List<EPF>>> getEPFs(EPFModel? epf);
  Future<Either<Failure, bool>> addEPF(EPFModel epf);
  Future<Either<Failure, bool>> updateEPF(EPFModel epf);
}
