import 'dart:io';

import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payroll_system/core/cubit/settings/settings_cubit.dart';
import 'package:payroll_system/features/addition/domain/addition.dart';
import 'package:payroll_system/features/department/domain/entities/designation.dart';
import 'package:payroll_system/features/payroll/blocs/payroll_generator/payroll_generator_cubit.dart';
import 'package:payroll_system/features/payroll/entities/eligible_employee.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfHelper {
  Future<File> generatePayrollPdf({
    required String month,
    required EligibleEmployee eligibleEmployee,
    required PayrollGeneratorState payrollState,
    Designation? employeeDesignation,
    required material.BuildContext materialContext,
  }) async {
    final pdf = pw.Document();
    //get current year
    final year = DateTime.now().year.toString();
    final salary = materialContext.read<SettingsCubit>().getBasicSalary(
        workDays: eligibleEmployee.totalDays,
        allowance: employeeDesignation?.allowance);

    List<Addition> deductions = [];
    List<Addition> additions = [];

    deductions = payrollState.deductions
            ?.where(
                (element) => element.selectedForPayroll && element.isMonthly)
            .toList() ??
        [];
    additions = payrollState.additions
            ?.where(
                (element) => element.selectedForPayroll && element.isMonthly)
            .toList() ??
        [];

    final epfFromEmployee =
        materialContext.read<SettingsCubit>().epfForBasicSalary(salary.basic);

    final epfFromCompany =
        materialContext.read<SettingsCubit>().comContEPF(salary.basic);

    final etf = materialContext.read<SettingsCubit>().etf(salary.basic);

    double totalDeductions = epfFromEmployee;
    double totalAdditions = 0;

    for (final add in additions) {
      totalAdditions += add.amount;
    }

    for (final deduct in deductions) {
      totalDeductions += deduct.amount;
    }

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.zero,
            margin: pw.EdgeInsets.zero,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Center(
              child: pw.Column(
                children: [
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Company Name',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Pay Advice',
                    style: const pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Table(
                    border: pw.TableBorder.all(),
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              '$month - $year',
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              '${eligibleEmployee.surename[0]}.${eligibleEmployee.firstName}',
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      ////
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'No of Days',
                              textAlign: pw.TextAlign.left,
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              eligibleEmployee.totalDays.toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Basic Salary',
                              textAlign: pw.TextAlign.left,
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              salary.basic.toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Allowance',
                              textAlign: pw.TextAlign.left,
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              salary.allowance.toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Total for EPF',
                              textAlign: pw.TextAlign.left,
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              salary.basic.toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Total',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              '',
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Gross Salary',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              (salary.basic + salary.allowance)
                                  .toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///

                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Deductions',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              '',
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'EPF 8%',
                              textAlign: pw.TextAlign.left,
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              epfFromEmployee.toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                              style: const pw.TextStyle(),
                            ),
                          ),
                        ],
                      ),

                      if (deductions.isNotEmpty)
                        ...deductions
                            .map((deduct) => pw.TableRow(
                                  children: [
                                    pw.Padding(
                                      padding: rowPadding,
                                      child: pw.Text(
                                        deduct.name,
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: rowPadding,
                                      child: pw.Text(
                                        deduct.amount.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.right,
                                        style: const pw.TextStyle(),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Total Deductions',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              (totalDeductions).toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///
                      if (additions.isNotEmpty)
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: rowPadding,
                              child: pw.Text(
                                'Additions',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: rowPadding,
                              child: pw.Text(
                                '',
                                textAlign: pw.TextAlign.right,
                              ),
                            ),
                          ],
                        ),

                      if (additions.isNotEmpty)
                        ...additions
                            .map((addition) => pw.TableRow(
                                  children: [
                                    pw.Padding(
                                      padding: rowPadding,
                                      child: pw.Text(
                                        addition.name,
                                        textAlign: pw.TextAlign.left,
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: rowPadding,
                                      child: pw.Text(
                                        addition.amount.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.right,
                                        style: const pw.TextStyle(),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),

                      if (additions.isNotEmpty)
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: rowPadding,
                              child: pw.Text(
                                'Total Additions',
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: rowPadding,
                              child: pw.Text(
                                totalAdditions.toStringAsFixed(2),
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.right,
                              ),
                            ),
                          ],
                        ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Net Salary',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              (((salary.basic + salary.allowance) +
                                          totalAdditions) -
                                      totalDeductions)
                                  .toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'Com Cont. EPF 12%',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              epfFromCompany.toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'EPF Total',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              (epfFromCompany + epfFromEmployee)
                                  .toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'ETF 3%',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              (etf).toStringAsFixed(2),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      ///
                      pw.TableRow(
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex('#AD9D99'),
                        ),
                        children: [
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              'EPF No.',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: rowPadding,
                            child: pw.Text(
                              eligibleEmployee.epfNumber.toString(),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 18),
                  pw.Text('Company @$year'),
                  pw.SizedBox(height: 18),
                ],
              ),
            ),
          );
        },
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}

const rowPadding = pw.EdgeInsets.all(2);
