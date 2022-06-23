// import 'dart:convert';

// import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../../core/error/exceptions.dart';
// import '../number_trivia_local_datasource.dart';

// const kCachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

// class NumberTriviaDataSourceImpl implements NumberTriviaLocalDataSource {
//   SharedPreferences? sharedPreferences;

//   NumberTriviaDataSourceImpl(this.sharedPreferences);

//   @override
//   Future<bool> cacheNumberTrivia(NumberTriviaModel trivia) async {
//     sharedPreferences ??= await SharedPreferences.getInstance();
//     return await sharedPreferences!
//         .setString(kCachedNumberTrivia, json.encode(trivia.toJson()));
//   }

//   @override
//   Future<NumberTriviaModel> getLastNumberTrivia() async {
//     sharedPreferences ??= await SharedPreferences.getInstance();
//     final jsonString = sharedPreferences!.getString(kCachedNumberTrivia);
//     if (jsonString != null) {
//       return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
//     } else {
//       throw CacheException();
//     }
//   }
// }
