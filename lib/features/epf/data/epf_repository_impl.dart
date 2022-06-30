import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/features/epf/data/epf_model.dart';
import 'package:payroll_system/features/epf/domain/epf.dart';
import 'package:payroll_system/features/epf/domain/epf_repository.dart';

import '../../../core/error/exceptions.dart';
import 'epf_data_source.dart';

class EPFRepositoryImpl extends EPFRepository {
  EPFRepositoryImpl(this._epfDataSource);
  final EPFDataSource _epfDataSource;

  @override
  Future<Either<Failure, bool>> addEPF(EPFModel epf) async {
    try {
      return Right(await _epfDataSource.addEPF(epf));
    } on NotAuthorizedExecption {
      return Left(AuthorizationFailure());
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EPF>>> getEPFs(EPFModel? epf) async {
    try {
      return Right(await _epfDataSource.getEPFs(filter: epf));
    } on NotAuthorizedExecption {
      return Left(AuthorizationFailure());
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateEPF(EPFModel epf) async {
    try {
      return Right(await _epfDataSource.updateEPF(epf));
    } on NotAuthorizedExecption {
      return Left(AuthorizationFailure());
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }
}
