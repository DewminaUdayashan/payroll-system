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

extension MonthExt on int {
  String get toMonthName {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Unknown';
    }
  }
}

extension MonthToInt on String {
  int get toMonthInt {
    switch (this) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        return 0;
    }
  }
}
