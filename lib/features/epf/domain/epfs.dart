import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/core/usecases/usecase.dart';
import 'package:payroll_system/features/epf/data/epf_model.dart';
import 'package:payroll_system/features/epf/domain/epf_repository.dart';

import 'epf.dart';

class EPFs extends UseCase<List<EPF>, EPFModel?> {
  EPFs(this._repository);
  final EPFRepository _repository;

  @override
  Future<Either<Failure, List<EPF>>> call(EPFModel? params) {
    return _repository.getEPFs(params);
  }

  //update
  Future<Either<Failure, bool>> updateEPF(EPFModel epf) async {
    return _repository.updateEPF(epf);
  }

  //insert
  Future<Either<Failure, bool>> addEPF(EPFModel epf) async {
    return _repository.addEPF(epf);
  }

  // Future<Either<Failure,List<EPF>>>
}
