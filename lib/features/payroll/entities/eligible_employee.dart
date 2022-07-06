import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class EligibleEmployee {
  final int id;
  final String surename;
  final String firstName;
  int? epfNumber;
  final double totalDays;

  EligibleEmployee({
    required this.id,
    required this.surename,
    required this.firstName,
    this.epfNumber,
    required this.totalDays,
  });

  EligibleEmployee copyWith({
    int? id,
    String? surename,
    String? firstName,
    int? epfNumber,
    double? totalDays,
  }) {
    return EligibleEmployee(
      id: id ?? this.id,
      surename: surename ?? this.surename,
      firstName: firstName ?? this.firstName,
      epfNumber: epfNumber ?? this.epfNumber,
      totalDays: totalDays ?? this.totalDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'surename': surename,
      'firstName': firstName,
      'epfNumber': epfNumber,
      'totalDays': totalDays,
    };
  }

  factory EligibleEmployee.fromMap(Map<String, dynamic> map) {
    return EligibleEmployee(
      id: map['id'] as int,
      surename: map['surename'] as String,
      firstName: map['first_name'] as String,
      epfNumber: map['epf_id'],
      totalDays: double.parse(map['total_days'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory EligibleEmployee.fromJson(String source) =>
      EligibleEmployee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EligibleEmployee(id: $id, surename: $surename, firstName: $firstName, epfNumber: $epfNumber, totalDays: $totalDays)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EligibleEmployee &&
        other.id == id &&
        other.surename == surename &&
        other.firstName == firstName &&
        other.epfNumber == epfNumber &&
        other.totalDays == totalDays;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        surename.hashCode ^
        firstName.hashCode ^
        epfNumber.hashCode ^
        totalDays.hashCode;
  }
}
