// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Addition extends Equatable {
  final int? id;
  final int employeeId;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final double amount;
  final bool isDeduction;
  final bool isActive;
  bool isMonthly;
  bool selectedForPayroll;

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
    this.selectedForPayroll = true,
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
    bool? selectedForPayroll,
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
      selectedForPayroll: selectedForPayroll ?? this.selectedForPayroll,
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
      employeeId: map['employee_id'] as int,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      startDate: DateTime.parse(map['start_date']),
      endDate: map['end_date'] != null ? DateTime.parse(map['endDate']) : null,
      amount: double.parse(map['amount'].toString()),
      isDeduction: map['is_deduction'] as bool,
      isActive: map['is_active'] as bool,
      isMonthly: map['is_monthly'] as bool,
      selectedForPayroll: true,
    );
  }

  String toJson() => json.encode(toMap());

  factory Addition.fromJson(String source) =>
      Addition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Addition(selectedForPayroll: $selectedForPayroll id: $id, employeeId: $employeeId, name: $name, description: $description, startDate: $startDate, endDate: $endDate, amount: $amount, isDeduction: $isDeduction, isActive: $isActive, isMonthly: $isMonthly)';
  }

  @override
  List<Object?> get props => [
        selectedForPayroll,
        id,
        employeeId,
        name,
        description,
        startDate,
        endDate,
        amount,
        isDeduction,
        isActive,
        isMonthly,
      ];
}
