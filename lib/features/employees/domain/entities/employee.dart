// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../shared/emp_enums.dart';

class Employee {
  final int? id;
  final int designationId;
  final String surename;
  final String firstName;
  final String? lastName;
  final String nic;
  final DateTime dateOfBirth;
  final Gender gender;
  final String mobile1;
  final String? mobile2;
  final String? email;
  final String? accountNo;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  final DateTime joinedDate;
  final DateTime? resignedDate;
  final int? epfNumber;
  final String? url;

  Employee({
    this.id,
    required this.designationId,
    required this.surename,
    required this.firstName,
    this.lastName,
    required this.nic,
    required this.dateOfBirth,
    required this.gender,
    required this.mobile1,
    this.mobile2,
    this.email,
    this.accountNo,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    required this.joinedDate,
    this.resignedDate,
    this.epfNumber,
    this.url,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.id == id &&
        other.designationId == designationId &&
        other.surename == surename &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.nic == nic &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.mobile1 == mobile1 &&
        other.mobile2 == mobile2 &&
        other.email == email &&
        other.accountNo == accountNo &&
        other.addressLine1 == addressLine1 &&
        other.addressLine2 == addressLine2 &&
        other.addressLine3 == addressLine3 &&
        other.joinedDate == joinedDate &&
        other.resignedDate == resignedDate &&
        other.epfNumber == epfNumber &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        designationId.hashCode ^
        surename.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        nic.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        mobile1.hashCode ^
        mobile2.hashCode ^
        email.hashCode ^
        accountNo.hashCode ^
        addressLine1.hashCode ^
        addressLine2.hashCode ^
        addressLine3.hashCode ^
        joinedDate.hashCode ^
        resignedDate.hashCode ^
        epfNumber.hashCode ^
        url.hashCode;
  }
}
