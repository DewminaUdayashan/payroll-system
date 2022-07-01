// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Addition {
  final int? id;
  final int employeeId;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final double amount;
  final bool isDeduction;
  final bool isActive;
  final bool isMonthly;

  Addition({
    this.id,
    required this.employeeId,
    required this.name,
    this.description,
    required this.startDate,
    this.endDate,
    required this.amount,
    required this.isDeduction,
    required this.isActive,
    required this.isMonthly,
  });

  Addition copyWith({
    int? id,
    int? employeeId,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    double? amount,
    bool? isDeduction,
    bool? isActive,
    bool? isMonthly,
  }) {
    return Addition(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      amount: amount ?? this.amount,
      isDeduction: isDeduction ?? this.isDeduction,
      isActive: isActive ?? this.isActive,
      isMonthly: isMonthly ?? this.isMonthly,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeId': employeeId,
      'name': name,
      'description': description,
      'startDate': startDate.toString(),
      'endDate': endDate != null ? endDate.toString() : null,
      'amount': amount,
      'isDeduction': isDeduction,
      'isActive': isActive,
      'isMonthly': isMonthly,
    };
  }

  factory Addition.fromMap(Map<String, dynamic> map) {
    return Addition(
      id: map['id'] != null ? map['id'] as int : null,
      employeeId: map['employeeId'] as int,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int)
          : null,
      amount: map['amount'] as double,
      isDeduction: map['isDeduction'] as bool,
      isActive: map['isActive'] as bool,
      isMonthly: map['isMonthly'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Addition.fromJson(String source) =>
      Addition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Addition(id: $id, employeeId: $employeeId, name: $name, description: $description, startDate: $startDate, endDate: $endDate, amount: $amount, isDeduction: $isDeduction, isActive: $isActive, isMonthly: $isMonthly)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Addition &&
        other.id == id &&
        other.employeeId == employeeId &&
        other.name == name &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.amount == amount &&
        other.isDeduction == isDeduction &&
        other.isActive == isActive &&
        other.isMonthly == isMonthly;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        employeeId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        amount.hashCode ^
        isDeduction.hashCode ^
        isActive.hashCode ^
        isMonthly.hashCode;
  }
}
