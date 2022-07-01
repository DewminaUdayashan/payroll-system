enum AdditionType {
  addition,
  deduction,
}

//extention to get AdditionType name
extension AdditionTypeExtension on AdditionType {
  String get name {
    switch (this) {
      case AdditionType.addition:
        return 'Addition';
      case AdditionType.deduction:
        return 'Deduction';
    }
  }

  bool isDeduction() {
    return this == AdditionType.deduction;
  }
}
