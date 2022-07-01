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
  final String? addressLine1;
  final String? addressLine2;
  final String? addressLine3;
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
}
