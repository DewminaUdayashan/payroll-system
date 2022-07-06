import 'package:dartz/dartz.dart';
import 'package:payroll_system/core/error/failure.dart';
import 'package:payroll_system/features/addition/data/addition_data_source.dart';

import 'addition.dart';

class AdditionRepository {
  AdditionRepository(this._dataSource);
  final AdditionDataSource _dataSource;

  Future<Either<Failure, bool>> addAddition(Addition addition) async {
    try {
      return Right(await _dataSource.addAddition(addition));
    } catch (e) {
      return Left(ApiFailure(code: 0, message: e.toString()));
    }
  }

  Future<Either<Failure, List<Addition>>> getAdditions(int employeeId) async {
    try {
      return Right(await _dataSource.getAddditions(employeeId));
    } catch (e) {
      return Left(ApiFailure(code: 0, message: e.toString()));
    }
  }
}
