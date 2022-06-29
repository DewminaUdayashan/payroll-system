// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../shared/emp_enums.dart';

class Employee {
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
  final String addressLine1;
  final String? addressLine2;
  final String? addressLine3;
  final DateTime joinedDate;
  final DateTime? resignedDate;
  final String? epfNumber;

  Employee({
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
    required this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    required this.joinedDate,
    this.resignedDate,
    this.epfNumber,
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
  }) {
    return Employee(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'surename': surename,
      'firstName': firstName,
      'lastName': lastName,
      'nic': nic,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'gender': gender.genderBool,
      'mobile1': mobile1,
      'mobile2': mobile2,
      'email': email,
      'accountNo': accountNo,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'addressLine3': addressLine3,
      'joinedDate': joinedDate,
      'resignedDate': resignedDate,
      'epfNumber': epfNumber,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      surename: map['surename'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      nic: map['nic'] as String,
      dateOfBirth:
          DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      gender: genderFromDB(map['gender']),
      mobile1: map['mobile1'] as String,
      mobile2: map['mobile2'] != null ? map['mobile2'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      accountNo: map['accountNo'] != null ? map['accountNo'] as String : null,
      addressLine1: map['addressLine1'] as String,
      addressLine2:
          map['addressLine2'] != null ? map['addressLine2'] as String : null,
      addressLine3:
          map['addressLine3'] != null ? map['addressLine3'] as String : null,
      joinedDate: DateTime.parse(map['joinedDate']),
      resignedDate: map['resignedDate'] != null
          ? DateTime.parse(map['resignedDate'])
          : null,
      epfNumber: map['epfNumber'] != null ? map['epfNumber'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Employee(surename: $surename, firstName: $firstName, lastName: $lastName, nic: $nic, dateOfBirth: $dateOfBirth, gender: $gender, mobile1: $mobile1, mobile2: $mobile2, email: $email, accountNo: $accountNo, addressLine1: $addressLine1, addressLine2: $addressLine2, addressLine3: $addressLine3, joinedDate: $joinedDate, resignedDate: $resignedDate, epfNumber: $epfNumber)';
  }
}
