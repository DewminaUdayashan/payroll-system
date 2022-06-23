import 'package:dartz/dartz.dart';

import '../error/failure.dart';

/// to force all usecases to be some standard format
abstract class UseCase<Type, Params> {
  ///so now all usecases is forced to have call method
  ///[type & params is dynamic]
  ///in the method we set type to [Failure] as we allways return failure from left side
  ///and type remains dynamic
  ///so each usecase classes can have different type of call method
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
