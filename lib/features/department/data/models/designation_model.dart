import 'package:payroll_system/features/department/domain/entities/designation.dart';

class DesignationModel extends Designation {
  DesignationModel({
    super.id,
    required super.name,
    required super.departmentId,
    required super.allowance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'departmentId': departmentId,
      'allowance': allowance,
    };
  }

  factory DesignationModel.fromMap(Map<String, dynamic> map) {
    return DesignationModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      departmentId: map['departmentId'] as int,
      allowance: map['allowance'] as double,
    );
  }
}
