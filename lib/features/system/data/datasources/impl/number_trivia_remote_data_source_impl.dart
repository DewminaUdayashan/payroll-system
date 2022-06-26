// import 'dart:convert';

// import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
// import 'package:http/http.dart' as http;
// import '../../../../../core/error/exceptions.dart';
// import '../number_trivia_remote_datasource.dart';

// class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
//   final http.Client client;

//   NumberTriviaRemoteDataSourceImpl(this.client);
//   @override
//   Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
//       _getModelFromUrl('http:/numbersapi.com/$number/trivia?json');

//   @override
//   Future<NumberTriviaModel> getRandomNumberTrivia() =>
//       _getModelFromUrl('http://numbersapi.com/random/trivia?json');

//   Future<NumberTriviaModel> _getModelFromUrl(String url) async {
//     final response = await client.get(
//       Uri.parse(url),
//       // headers: {
//       //   'Content-Type': 'application/json',
//       // },
//     );
//     if (response.statusCode == 200) {
//       return NumberTriviaModel.fromJson(json.decode(response.body));
//     } else {
//       throw ServerException();
//     }
//   }
// }
