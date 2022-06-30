import 'package:payroll_system/features/epf/domain/epf.dart';

class EPFModel extends EPF {
  EPFModel({required super.epfNo, required super.total, super.updateAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'epfNo': epfNo,
      'total': total,
      'updateAt': updateAt.toString(),
    };
  }

  factory EPFModel.fromMap(Map<String, dynamic> map) {
    return EPFModel(
      epfNo: map['epfNo'] as int,
      total: map['total'] as double,
      updateAt: DateTime.tryParse(map['updateAt']),
    );
  }
}
