// ignore_for_file: public_member_api_docs, sort_constructors_first

class EPF {
  final int epfNo;
  final double total;
  final DateTime? updateAt;
  final int? employeeId;

  EPF({
    required this.epfNo,
    required this.total,
    this.updateAt,
    this.employeeId,
  });
}
