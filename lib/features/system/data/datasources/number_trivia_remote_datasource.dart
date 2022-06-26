import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  ///calls to the api endpoint
  ///throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
