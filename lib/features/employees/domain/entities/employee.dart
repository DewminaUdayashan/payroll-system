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
  final String? epfNumber;
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

  Employee copyWith({
    String? surename,
    String? firstName,
    String? lastName,
    String? nic,
    DateTime? dateOfBirth,
    Gender? gender,
    String? mobile1,
    String? mobile2,
    String? email,
    String? accountNo,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    DateTime? joinedDate,
    DateTime? resignedDate,
    String? epfNumber,
    int? id,
    int? designationId,
  }) {
    return Employee(
      id: id ?? this.id,
      designationId: designationId ?? this.designationId,
      surename: surename ?? this.surename,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nic: nic ?? this.nic,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      mobile1: mobile1 ?? this.mobile1,
      mobile2: mobile2 ?? this.mobile2,
      email: email ?? this.email,
      accountNo: accountNo ?? this.accountNo,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      addressLine3: addressLine3 ?? this.addressLine3,
      joinedDate: joinedDate ?? this.joinedDate,
      resignedDate: resignedDate ?? this.resignedDate,
      epfNumber: epfNumber ?? this.epfNumber,
    );
  }
}
