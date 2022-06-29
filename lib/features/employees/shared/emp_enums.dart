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
