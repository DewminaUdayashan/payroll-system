import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'employee_data_title_bar.dart';
import 'employees_action_bar.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmployeesActionBar(),
        const EmployeeDataTitleBar(),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ListTile(
                enableFeedback: true,
                onTap: () {},
                title: Row(
                  children: [
                    const Expanded(
                      flex: idFlex,
                      child: Text(
                        '10001',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: nameFlex,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
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
                          const Text(
                            'Smarsingh Jhone Doe',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                        flex: departmentFlex,
                        child: Text(
                          'IT',
                          textAlign: TextAlign.center,
                        )),
                    const Expanded(
                        flex: contactFlex,
                        child: Text(
                          '0724xxxxxx\n024xxxxxxx',
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                      flex: actionFlex,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: const Icon(Icons.more_vert),
                          // ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
