import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';
import 'package:payroll_system/features/department/domain/usecase/designations.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/shared/dialogs.dart';
import '../../../../../core/shared/notification_helper.dart';
import '../../../data/models/designation_model.dart';

part 'designations_state.dart';

class DesignationsCubit extends Cubit<DesignationsState> {
  DesignationsCubit(this._designations) : super(DesignationsLoading());
  final Designations _designations;

  final List<Designation> designationsTmp = <Designation>[];

  Future<void> getDesignations({
    Designation? designation,
  }) async {
    emit(DesignationsLoading());
    try {
      final designations = await _designations(designation);
      designations.fold(
        (failure) {
          if (failure is FetchFaiure) {
            emit(DesignationsError(message: failure.message));
          } else if (failure is ApiFailure) {
            emit(DesignationsError(message: failure.message));
          } else {
            emit(const DesignationsError(message: 'Something went wrong...'));
          }
        },
        (result) {
          designationsTmp.clear();
          designationsTmp.addAll(result);
          emit(DesignationsLoaded(designations: result));
        },
      );
    } catch (e) {
      emit(DesignationsError(message: e.toString()));
    }
  }

  void addDesignation(DesignationModel designation, BuildContext context) {
    Navigator.pop(context);

    showLoadingDialog(context);
    _designations.insert(designation).then(
          (result) => result.fold(
            (failure) {
              Navigator.pop(context);
              if (failure is FetchFaiure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else if (failure is ApiFailure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else {
                NotificationHelper.error(context: context);
              }
            },
            (inserted) {
              Navigator.pop(context);
              NotificationHelper.success(context: context);
              getDesignations();
            },
          ),
        );
  }

  void updateDepartmet(DesignationModel designation, BuildContext context) {
    Navigator.pop(context);
    showLoadingDialog(context);
    _designations.update(designation).then(
          (result) => result.fold(
            (failure) {
              Navigator.pop(context);
              if (failure is FetchFaiure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else if (failure is ApiFailure) {
                NotificationHelper.error(
                    context: context, subtitle: failure.message);
              } else {
                NotificationHelper.error(context: context);
              }
            },
            (inserted) {
              Navigator.pop(context);
              NotificationHelper.success(
                  context: context,
                  subtitle: 'Designation updated successfully');
              getDesignations();
            },
          ),
        );
  }

  void searchDesignation(String? value) {
    if (value != null && value.length > 1) {
      getDesignations(
          designation: DesignationModel(
              name: value.trim(), allowance: 0.0, departmentId: 0));
    } else {
      getDesignations();
    }
  }

  String getDesignationNameById(int designationId) {
    if (designationsTmp.isNotEmpty) {
      return designationsTmp
          .firstWhere((element) => element.id == designationId)
          .name;
    } else {
      return '';
    }
  }
}
