import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static void success({
    String title = 'Succeed..!',
    String subtitle = 'Data successfully inserted',
    required BuildContext context,
  }) {
    ElegantNotification.success(
      title: Text(title),
      description: Text(subtitle),
      showProgressIndicator: true,
      notificationPosition: NotificationPosition.bottom,
    ).show(context);
  }

  static void error({
    String title = 'Failed..!',
    String subtitle = 'Something went wrong..',
    required BuildContext context,
    bool showAction = true,
  }) {
    ElegantNotification.error(
      title: Text(title),
      description: Text(subtitle),
      showProgressIndicator: true,
      notificationPosition: NotificationPosition.bottom,
    ).show(context);
  }
}
