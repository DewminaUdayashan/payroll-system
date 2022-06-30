// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'emp_department_filter_cubit.dart';

class EmpDepartmentFilterState extends Equatable {
  const EmpDepartmentFilterState({
    this.department,
    this.designation,
    this.departmentNotSelected = false,
    this.designationNotSelected = false,
  });
  final Department? department;
  final Designation? designation;
  final bool departmentNotSelected;
  final bool designationNotSelected;

  @override
  List<Object?> get props => [
        department,
        designation,
        departmentNotSelected,
        designationNotSelected,
      ];

  EmpDepartmentFilterState copyWith({
    Department? department,
    Designation? designation,
    bool? departmentNotSelected,
    bool? designationNotSelected,
  }) {
    return EmpDepartmentFilterState(
      department: department ?? this.department,
      designation: designation ?? this.designation,
      departmentNotSelected:
          departmentNotSelected ?? this.departmentNotSelected,
      designationNotSelected:
          designationNotSelected ?? this.designationNotSelected,
    );
  }
}
