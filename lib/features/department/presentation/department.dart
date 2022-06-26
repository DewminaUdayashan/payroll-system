import 'package:flutter/material.dart';

class Department extends StatelessWidget {
  const Department({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text('Department'),
          ),
          DataColumn(
            label: Text('Employees'),
          ),
          DataColumn(
            label: Text('Average Salary'),
          ),
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(
                Text('Sales'),
              ),
              DataCell(
                Text('London'),
              ),
              DataCell(
                Text('12'),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text('IT'),
              ),
              DataCell(
                Text('London'),
              ),
              DataCell(
                Text('12'),
              ),
            ],
          ),
          DataRow(
            cells: [
              DataCell(
                Text('HR'),
              ),
              DataCell(
                Text('London'),
              ),
              DataCell(
                Text('12'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
