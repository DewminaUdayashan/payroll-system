import 'package:flutter/material.dart';

enum SystemTab { dashboard, task, employees, departments }

extension SystemTabExtension on SystemTab {
  String get name {
    switch (this) {
      case SystemTab.dashboard:
        return 'Dashboard';
      case SystemTab.task:
        return 'Task';
      case SystemTab.employees:
        return 'Employees';
      case SystemTab.departments:
        return 'Departments';
      default:
        return 'Dashboard';
    }
  }

  IconData get icon {
    switch (this) {
      case SystemTab.dashboard:
        return Icons.dashboard;
      case SystemTab.task:
        return Icons.assignment;
      case SystemTab.employees:
        return Icons.people;
      case SystemTab.departments:
        return Icons.business;
      default:
        return Icons.dashboard;
    }
  }
}
