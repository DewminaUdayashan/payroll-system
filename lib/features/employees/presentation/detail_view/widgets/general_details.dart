import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../department/presentation/blocs/designations_cubit/designations_cubit.dart';
import '../../blocs/employee_page_controller/employee_page_controller_cubit.dart';

class GeneralDetails extends StatelessWidget {
  const GeneralDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'General Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: const Divider(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    context
                        .read<EmployeePageControllerCubit>()
                        .employee
                        .id
                        .toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${context.read<EmployeePageControllerCubit>().employee.surename} ${context.read<EmployeePageControllerCubit>().employee.firstName} ${context.read<EmployeePageControllerCubit>().employee.lastName ?? ''}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NIC : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    context.read<EmployeePageControllerCubit>().employee.nic,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date of Birth : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(context
                        .read<EmployeePageControllerCubit>()
                        .employee
                        .dateOfBirth),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${context.read<EmployeePageControllerCubit>().employee.addressLine1 ?? ''},${context.read<EmployeePageControllerCubit>().employee.addressLine2 ?? ''},${context.read<EmployeePageControllerCubit>().employee.addressLine3 ?? ''}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Designation : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    context.read<DesignationsCubit>().getDesignationNameById(
                        context
                            .read<EmployeePageControllerCubit>()
                            .employee
                            .designationId),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Number : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${context.read<EmployeePageControllerCubit>().employee.mobile1} \n ${context.read<EmployeePageControllerCubit>().employee.mobile2}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    context
                            .read<EmployeePageControllerCubit>()
                            .employee
                            .email ??
                        'Not defined',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    context
                        .read<EmployeePageControllerCubit>()
                        .employee
                        .gender
                        .name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Account : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    context
                            .read<EmployeePageControllerCubit>()
                            .employee
                            .accountNo ??
                        'Not defined',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
          const Expanded(
            child: Icon(
              Icons.image_rounded,
              size: 70,
            ),
          ),
        ],
      ),
    );
  }
}
