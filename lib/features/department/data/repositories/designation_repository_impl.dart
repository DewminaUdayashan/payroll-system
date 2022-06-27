import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/features/department/data/models/designation_model.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';
import 'package:payroll_system/features/department/domain/repositories/designation_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/designation_data_source.dart';

class DesignationRepositoryImpl extends DesignationRepository {
  DesignationRepositoryImpl(this._dataSource);
  final DesignationDataSource _dataSource;

  @override
  Future<Either<Failure, List<Designation>>> getdesignations(
      {Designation? filter}) async {
    try {
      return Right(await _dataSource.getDesignations(filter: filter));
    } on FetchFailed catch (e) {
      return Left(FetchFaiure(code: e.code, message: e.message));
    } on ServerException catch (e) {
      return Left(ApiFailure(code: e.code, message: e.message));
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> insertdesignation(
      {required DesignationModel designation}) async {
    try {
      return Right(
          await _dataSource.insertDesignation(designation: designation));
    } on NotAuthorizedExecption {
      return Left(AuthorizationFailure());
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updatedesignation(
      {required DesignationModel designation}) async {
    try {
      return Right(
          await _dataSource.updateDesignation(designation: designation));
    } on NotAuthorizedExecption {
      return Left(AuthorizationFailure());
    } catch (e, stack) {
      return Left(
          ApiFailure(code: 400, message: e.toString() + stack.toString()));
    }
  }
}
