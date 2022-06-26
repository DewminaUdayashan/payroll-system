import '../../domain/entities/number_trivia.dart';

/// [extend entities] to create the model
/// this way is used to make [domain layer] completely independent
/// methods like toJson, fromJson should be in data layer actually
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required String text, required int number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> map) {
    return NumberTriviaModel(
      text: map['text'] ?? '',
      number: map['number']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({"text": text});
    result.addAll({"number": number});

    return result;
  }
}
