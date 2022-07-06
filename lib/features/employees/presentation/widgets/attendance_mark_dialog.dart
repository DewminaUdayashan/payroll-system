import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/employees/domain/entities/attendance.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';
import 'package:payroll_system/features/employees/presentation/employees_add/widgets/text_field_widget.dart';

class AttendanceMarkDialog extends StatefulWidget {
  const AttendanceMarkDialog(this.employee, {Key? key}) : super(key: key);
  final Employee employee;

  @override
  State<AttendanceMarkDialog> createState() => _AttendanceMarkDialogState();
}

class _AttendanceMarkDialogState extends State<AttendanceMarkDialog> {
  late int selectedMonth;
  late String year;
  final TextEditingController workDays = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now().month;
    year = DateFormat('yyyy').format(
      DateTime.now(),
    );
  }

  @override
  void dispose() {
    workDays.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          'Mark Attendance for ${widget.employee.firstName} - ${widget.employee.nic}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                  label: 'Year',
                  readOnly: true,
                  controller: TextEditingController(
                    text: year,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Month : ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<int>(
                        value: selectedMonth,
                        underline: const SizedBox.shrink(),
                        items: [
                          for (int i = 1; i <= 12; i++)
                            DropdownMenuItem(
                              value: i,
                              child: Text(
                                DateFormat('MMMM').format(
                                  DateTime(DateTime.now().month, i),
                                ),
                              ),
                            ),
                        ],
                        onChanged: (int? month) {
                          if (month != null) {
                            setState(() {
                              selectedMonth = month;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: workDays,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            ],
            maxLength: 4,
            decoration: const InputDecoration(
              labelText: 'Work Days',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Attendance attendanceRecord = Attendance(
              employeeId: widget.employee.id!,
              month: selectedMonth.toString(),
              year: year,
              workDays: double.parse(workDays.text),
            );
            markAttendance(attendanceRecord, () {
              Navigator.pop(context);
            });
          },
          style: TextButton.styleFrom(
            primary: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: const Text('Mark'),
        ),
      ],
    );
  }

  Future<void> markAttendance(
      Attendance attendanceRecord, VoidCallback onMarked) async {
    final marked = await API.post(
      endPoint: 'attendance/mark',
      data: attendanceRecord.toMap(),
    );
    if (marked.statusCode == 200) {
      if (jsonDecode(marked.body)['data'] == 1) {
        NotificationHelper.info(
          context: context,
          title: 'Attendance already marked for this month',
          subtitle: 'Please check the attendance record for this month',
        );
      } else {
        onMarked.call();
      }
    } else {
      NotificationHelper.error(
          context: context, subtitle: marked.body.toString());
    }
  }
}
