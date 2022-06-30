import 'package:payroll_system/features/epf/data/epf_model.dart';

import '../domain/epf.dart';

abstract class EPFDataSource {
  Future<List<EPF>> getEPFs({EPFModel? filter});
  Future<bool> addEPF(EPFModel epf);
  Future<bool> updateEPF(EPFModel epf);
}
