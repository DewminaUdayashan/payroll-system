import 'package:payroll_system/features/epf/domain/epf.dart';

class EPFModel extends EPF {
  EPFModel(
      {required super.epfNo,
      required super.total,
      super.updateAt,
      super.employeeId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'epfNo': epfNo,
      'total': total,
      'updateAt': updateAt.toString(),
      'employeeId': employeeId,
    };
  }

  factory EPFModel.fromMap(Map<String, dynamic> map) {
    return EPFModel(
      epfNo: map['epf_no'] as int,
      total: double.parse(map['total'].toString()),
      updateAt: DateTime.tryParse(map['update_at']),
    );
  }
}
