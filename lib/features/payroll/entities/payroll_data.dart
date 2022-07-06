import 'eligible_employee.dart';

class PayrollData {
  final double netSalary;
  final int year;
  final String month;
  final EligibleEmployee issuedTo;
  final int issuedBy;
  final double epf;
  final double etf;

  PayrollData({
    required this.netSalary,
    required this.year,
    required this.month,
    required this.issuedTo,
    required this.issuedBy,
    required this.epf,
    required this.etf,
  });

  PayrollData copyWith({
    double? netSalary,
    int? year,
    String? month,
    EligibleEmployee? issuedTo,
    int? issuedBy,
    double? epf,
    double? etf,
  }) {
    return PayrollData(
      netSalary: netSalary ?? this.netSalary,
      year: year ?? this.year,
      month: month ?? this.month,
      issuedTo: issuedTo ?? this.issuedTo,
      issuedBy: issuedBy ?? this.issuedBy,
      epf: epf ?? this.epf,
      etf: etf ?? this.etf,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'netSalary': netSalary,
      'year': year,
      'month': month,
      'issuedTo': issuedTo.toMap(),
      'issuedBy': issuedBy,
      'epf': epf,
      'etf': etf,
    };
  }

  factory PayrollData.fromMap(Map<String, dynamic> map) {
    return PayrollData(
      netSalary: map['netSalary'] as double,
      year: map['year'] as int,
      month: map['month'] as String,
      issuedTo:
          EligibleEmployee.fromMap(map['issuedTo'] as Map<String, dynamic>),
      issuedBy: map['issuedBy'] as int,
      epf: map['epf'] as double,
      etf: map['etf'] as double,
    );
  }
}
