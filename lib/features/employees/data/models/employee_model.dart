import 'package:payroll_system/features/employees/domain/entities/employee.dart';
import 'package:payroll_system/features/employees/shared/emp_enums.dart';

class EmployeeModel extends Employee {
  EmployeeModel({
    super.id,
    required super.designationId,
    required super.surename,
    required super.firstName,
    super.lastName,
    required super.nic,
    required super.dateOfBirth,
    required super.gender,
    required super.mobile1,
    super.mobile2,
    super.email,
    super.addressLine1,
    super.addressLine2,
    super.addressLine3,
    super.accountNo,
    super.epfNumber,
    required super.joinedDate,
    super.resignedDate,
    super.url,
  });

  Map<String, dynamic> toMapUpdate() {
    return <String, dynamic>{
      'id': id,
      'designationId': designationId,
      'surename': surename,
      'firstName': firstName,
      'lastName': lastName,
      'nic': nic,
      'dob': dateOfBirth.toString(),
      'sex': gender.genderBool,
      'mobile1': mobile1,
      'mobile2': mobile2,
      'email': email,
      'accountNo': accountNo,
      'address1': addressLine1,
      'address2': addressLine2,
      'address3': addressLine3,
      'joinedDate': joinedDate.toString(),
      'resignedDate': resignedDate,
      'epf': epfNumber,
      'url': url,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'designationId': designationId,
      'surename': surename,
      'firstName': firstName,
      'lastName': lastName,
      'nic': nic,
      'dob': dateOfBirth.toString(),
      'sex': gender.genderBool,
      'mobile1': mobile1,
      'mobile2': mobile2,
      'email': email,
      'accountNo': accountNo,
      'address1': addressLine1,
      'address2': addressLine2,
      'address3': addressLine3,
      'joinedDate': joinedDate.toString(),
      'resignedDate': resignedDate,
      'epf': epfNumber,
      'url': url,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as int,
      designationId: map['designation_id'] as int,
      surename: map['surename'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      nic: map['nic'] as String,
      dateOfBirth: DateTime.parse(map['dob']),
      gender: genderFromDB(map['sex']),
      mobile1: map['mobile_1'] as String,
      mobile2: map['mobile_2'] != null ? map['mobile_2'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      accountNo: map['account_number'] != null
          ? map['account_number'] as String
          : null,
      joinedDate: DateTime.parse(map['joined_date']),
      resignedDate: map['resigned_date'] != null
          ? DateTime.parse(map['resigned_date'])
          : null,
      epfNumber: map['epf_id'] != null ? map['epf_id'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Employee(surename: $surename, firstName: $firstName, lastName: $lastName, nic: $nic, dateOfBirth: $dateOfBirth, gender: $gender, mobile1: $mobile1, mobile2: $mobile2, email: $email, accountNo: $accountNo, addressLine1: $addressLine1, addressLine2: $addressLine2, addressLine3: $addressLine3, joinedDate: $joinedDate, resignedDate: $resignedDate, epfNumber: $epfNumber)';
  }
}
