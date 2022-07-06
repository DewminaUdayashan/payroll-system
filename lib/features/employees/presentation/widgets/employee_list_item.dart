import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/employees/domain/entities/employee.dart';
import 'package:payroll_system/features/employees/presentation/widgets/attendance_mark_dialog.dart';

import '../../../addition/presentation/addition_dialog.dart';
import '../../../department/presentation/blocs/designations_cubit/designations_cubit.dart';
import '../blocs/employee_page_controller/employee_page_controller_cubit.dart';
import '../blocs/employees_cubit/employees_cubit.dart';
import 'employee_data_title_bar.dart';

class EmployeeListItem extends StatelessWidget {
  const EmployeeListItem(this.employee, this.index, {Key? key})
      : super(key: key);
  final Employee employee;
  final int index;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ListTile(
        enableFeedback: true,
        tileColor: index.isEven
            ? Theme.of(context).colorScheme.primaryContainer
            : null,
        onTap: () {},
        title: Row(
          children: [
            Expanded(
              flex: idFlex,
              child: Text(
                employee.id.toString(),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              flex: nameFlex,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: SizedBox(
                      width: 55.w,
                      height: 55.w,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMF7rNYRqdBhKmsTiW0pes2TrBJnzv7zqbjMp9W9J4cX4XK8jSeUmHBgHrgIt9AmANjxk&usqp=CAU',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    context.read<EmployeesCubit>().getFullName(employee),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: departmentFlex,
              child: Text(
                context
                    .read<DesignationsCubit>()
                    .getDesignationNameById(employee.designationId),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: contactFlex,
              child: Text(
                context.read<EmployeesCubit>().getContactDetails(employee),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: actionFlex,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AttendanceMarkDialog(employee));
                    },
                    icon: const Icon(Icons.add_task_rounded),
                    tooltip: 'Attendance',
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<EmployeePageControllerCubit>()
                          .currentEmployee = employee;
                      context
                          .read<EmployeePageControllerCubit>()
                          .changePAge(1, isEdit: true);
                    },
                    icon: const Icon(Icons.mode_edit_outline_outlined),
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) => AdditionDialog(employee: employee)),
                    icon: const Icon(Icons.add_box_outlined),
                    tooltip: 'Additions',
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<EmployeePageControllerCubit>()
                          .currentEmployee = employee;
                      context
                          .read<EmployeePageControllerCubit>()
                          .changePAge(1, isDetailView: true);
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                    tooltip: 'Details',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
