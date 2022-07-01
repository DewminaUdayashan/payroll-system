import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../employees/domain/entities/employee.dart';
import '../../../employees/presentation/blocs/employees_cubit/employees_cubit.dart';
import '../../../employees/presentation/employees_add/widgets/text_field_widget.dart';
import '../../data/epf_model.dart';
import '../blocs/epf/epf_cubit.dart';

class AddEPFSection extends StatefulWidget {
  const AddEPFSection({Key? key}) : super(key: key);

  @override
  State<AddEPFSection> createState() => _AddEPFSectionState();
}

class _AddEPFSectionState extends State<AddEPFSection> {
  final seachBarController = FloatingSearchBarController();
  final epfNo = TextEditingController();
  final employee = TextEditingController();
  Employee? selectedEmployee;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    seachBarController.dispose();
    epfNo.dispose();
    employee.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      seachBarController.hide();
      seachBarController.close();
    });
    return Stack(
      children: [
        BlocConsumer<EpfCubit, EpfState>(
          listener: (context, state) {
            if (state is EpfLoaded) {
              context.read<EmployeesCubit>().loadEmployees();
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add New EPF Account',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 25),
                        TextFieldWidget(
                          label: "EPF Number",
                          controller: epfNo,
                          textInputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9,]+')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                        const SizedBox(height: 25),
                        TextFieldWidget(
                          label: "Select Employee",
                          controller: employee,
                          readOnly: true,
                          onTap: () {
                            seachBarController.show();
                            seachBarController.open();
                          },
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: const Text('Warning.!'),
                                          content: const Text(
                                              'Are you sure you want to reset the form?'),
                                          actions: [
                                            TextButton(
                                              child: const Text('Yes'),
                                              onPressed: () {
                                                epfNo.clear();
                                                employee.clear();
                                                selectedEmployee = null;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('No'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ));
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(
                                'Rest',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: const Text('Confrmation.!'),
                                          content: Text(
                                              '''Are you sure you want to set EPF acccount${epfNo.text} to
                                                    \n${selectedEmployee?.nic} - ${selectedEmployee?.surename} ${selectedEmployee?.firstName}'''),
                                          actions: [
                                            TextButton(
                                              child: const Text('Yes'),
                                              onPressed: () {
                                                context.read<EpfCubit>().addEpf(
                                                    EPFModel(
                                                      epfNo:
                                                          int.parse(epfNo.text),
                                                      total: 0,
                                                      employeeId:
                                                          selectedEmployee!.id!,
                                                    ),
                                                    context);
                                                epfNo.clear();
                                                employee.clear();
                                                selectedEmployee = null;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('No'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ));
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: BlocBuilder<EmployeesCubit, EmployeesState>(
              builder: (context, state) {
                return FloatingSearchBar(
                  controller: seachBarController,
                  automaticallyImplyBackButton: false,
                  onQueryChanged: context.read<EmployeesCubit>().seachEmployee,
                  transition: CircularFloatingSearchBarTransition(),
                  hint: 'Search Employee...',
                  builder: (context, transition) {
                    if (state is EmployeesLoading || state is EmployeeError) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final empState =
                        context.read<EmployeesCubit>().state as EmployeesLoaded;
                    final notEnrolledForEPF = empState.employees
                        .where((element) => element.epfNumber == null)
                        .toList();
                    if (notEnrolledForEPF.isEmpty) {
                      return const Material(
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(
                              'No employees available without enrolled for EPF'),
                        ),
                      );
                    }
                    return Material(
                      child: Column(
                        children: notEnrolledForEPF
                            .map((e) => ListTile(
                                  onTap: () {
                                    selectedEmployee = e;
                                    employee.text = e.firstName;
                                    seachBarController.close();
                                    seachBarController.hide();
                                  },
                                  tileColor: Colors.white,
                                  selected: true,
                                  title: Text('${e.firstName} : ${e.nic}'),
                                ))
                            .toList(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
