enum EmployeeStatus {
  all,
  active,
  resigned,
}

//extension to get name of employee status
extension EmployeeStatusExtension on EmployeeStatus {
  String get name {
    switch (this) {
      case EmployeeStatus.all:
        return 'All';
      case EmployeeStatus.active:
        return 'Active';
      case EmployeeStatus.resigned:
        return 'Resigned';
      default:
        return 'Unknown';
    }
  }
}

enum Gender {
  male,
  female,
  notSelected;
}

extension GenderExtention on Gender {
  String get name {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      default:
        return 'Not Selected';
    }
  }

  int get genderBool {
    switch (this) {
      case Gender.male:
        return 1;
      default:
        return 0;
    }
  }
}

Gender genderFromDB(int gender) {
  switch (gender) {
    case 1:
      return Gender.male;
    default:
      return Gender.female;
  }
}
