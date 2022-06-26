import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:payroll_system/core/shared/app_theme.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 70.w,
              height: 70.w,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: loadingColors,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
