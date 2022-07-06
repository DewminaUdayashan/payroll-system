// ignore_for_file: public_member_api_docs, sort_constructors_first

class Attendance {
  final int employeeId;
  final String year;
  final String month;
  final double workDays;

  Attendance({
    required this.employeeId,
    required this.year,
    required this.month,
    required this.workDays,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
      'year': year,
      'month': month,
      'totalDays': workDays,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      employeeId: map['employeeId'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      workDays: map['workDays'] as double,
    );
  }

  @override
  String toString() {
    return 'Attendance(employeeId: $employeeId, year: $year, month: $month, workDays: $workDays)';
  }
}
