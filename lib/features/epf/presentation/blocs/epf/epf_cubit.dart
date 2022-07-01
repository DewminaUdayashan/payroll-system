import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/core/shared/notification_helper.dart';
import 'package:payroll_system/features/epf/data/epf_model.dart';
import 'package:payroll_system/features/epf/domain/epf.dart';
import 'package:payroll_system/features/epf/domain/epfs.dart';

part 'epf_state.dart';

class EpfCubit extends Cubit<EpfState> {
  EpfCubit(this._epfs) : super(EpfLoading());
  final EPFs _epfs;

  Future<void> getEpfs() async {
    emit(EpfLoading());
    try {
      final epfs = await _epfs(null);
      epfs.fold(
        (l) => emit(EpfError(
          message: l.toString(),
        )),
        (r) => emit(EpfLoaded(r)),
      );
    } catch (e) {
      emit(EpfError(message: e.toString()));
    }
  }

  Future<void> addEpf(EPFModel epf, BuildContext context) async {
    emit(EpfLoading());
    try {
      final epfs = await _epfs.addEPF(epf);
      epfs.fold(
        (l) => EpfError(
          message: l.toString(),
        ),
        (r) {
          NotificationHelper.success(
              context: context,
              title: 'Succeed..!',
              subtitle:
                  'EPF Number ${epf.epfNo} has been assigned to employee ${epf.employeeId}');
          getEpfs();
        },
      );
    } catch (e) {
      emit(EpfError(message: e.toString()));
    }
  }
}
