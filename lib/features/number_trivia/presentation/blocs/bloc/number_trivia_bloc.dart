// import 'package:bloc/bloc.dart';
// import 'package:clean_architecture/core/usecases/usecase.dart';
// import 'package:clean_architecture/core/utils/input_converter.dart';
// import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../../core/error/failure.dart';
// import '../../../domain/entities/number_trivia.dart';
// import '../../../domain/usecases/get_random_number_trivia.dart';

// part 'number_trivia_event.dart';
// part 'number_trivia_state.dart';

// class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
//   final GetConcreteNumberTrivia getConcreteNumberTrivia;
//   final GetRandomNumberTrivia getRandomNumberTrivia;
//   final InputConverter inputConverter;

//   NumberTriviaBloc({
//     required this.getConcreteNumberTrivia,
//     required this.getRandomNumberTrivia,
//     required this.inputConverter,
//   }) : super(Empty()) {
//     on<NumberTriviaEvent>((event, emit) async {
//       if (event is GetTriviaConcreteNumber) {
//         _getTiviaNumberCalled(event, emit);
//       } else if (event is GetTriviaRandomNumber) {
//         await _getTiviaRandomNumberCalled(event, emit)
//             .then((value) => value.fold((l) => emit(l), (r) => emit(r)));
//       }
//     });
//   }

//   Future<Either<Error, Loaded>> _getTiviaRandomNumberCalled(
//       GetTriviaRandomNumber event, Emitter<NumberTriviaState> emit) async {
//     emit(Loading());
//     final failureOrTrivia = await getRandomNumberTrivia(NoParams());
//     return failureOrTrivia.fold(
//       (fail) => Left(
//           Error(fail is ServerFailure ? kServerFailureMsg : kCacheFailureMsg)),
//       (trivia) => Right(Loaded(trivia)),
//     );
//   }

//   void _getTiviaNumberCalled(
//       GetTriviaConcreteNumber event, Emitter<NumberTriviaState> emit) {
//     emit(Loading());
//     final inputEither = inputConverter.stringToUnsignedInt(event.numberString);
//     inputEither.fold(
//       (failure) {
//         emit(const Error(kInvalidInputFailureMsg));
//       },
//       (integer) async {
//         final failureOrTrivia =
//             await getConcreteNumberTrivia(Params(number: integer));
//         final res = failureOrTrivia.fold(
//           (fail) => Error(
//               fail is ServerFailure ? kServerFailureMsg : kCacheFailureMsg),
//           (trivia) => Loaded(trivia),
//         );
//         emit(res);
//       },
//     );
//   }
// }

// const kServerFailureMsg = "Server Failur";
// const kCacheFailureMsg = "Cache Failur";
// const kInvalidInputFailureMsg = "Invalid Input";
