import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/features/employees/presentation/blocs/employees_cubit/employees_cubit.dart';
import 'package:payroll_system/features/epf/presentation/blocs/epf/epf_cubit.dart';
import 'package:payroll_system/features/epf/presentation/widgets/add_epf_section.dart';
import 'package:payroll_system/features/epf/presentation/widgets/epf_title_bar.dart';

class EPFPage extends StatefulWidget {
  const EPFPage({Key? key}) : super(key: key);
  @override
  State<EPFPage> createState() => _EPFPageState();
}

class _EPFPageState extends State<EPFPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: AddEPFSection()),
        Expanded(
          flex: 2,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: EpfTitleBar(),
                floating: true,
              ),
              SliverToBoxAdapter(
                child: Material(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: BlocBuilder<EpfCubit, EpfState>(
                      builder: (context, state) {
                        if (state is EpfLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is EpfError) {
                          return const Center(child: Text('Error'));
                        }
                        final currentState = state as EpfLoaded;
                        if (currentState.epfs.isEmpty) {
                          return const Center(child: Text('No EPF'));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: currentState.epfs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final epf = currentState.epfs[index];
                            return ListTile(
                              onTap: () {},
                              tileColor: index.isEven
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : null,
                              title: Row(children: [
                                Expanded(
                                  flex: epfNoFlex,
                                  child: Text(
                                    epf.epfNo.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: epfNameFlex,
                                  child: Text(
                                    context
                                        .read<EmployeesCubit>()
                                        .getEmployeeNameNicByEPFNo(epf.epfNo),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    flex: epfAmountFlex,
                                    child: Text(
                                      epf.total.toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                    )),
                                Expanded(
                                    flex: epfDateFlex,
                                    child: Text(
                                      epf.updateAt.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10.sp),
                                    )),
                              ]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
