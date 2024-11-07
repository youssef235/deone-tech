import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../app/app_keys.dart';

SnackBar buildSnackBar(
        {required String text, Color backgroundColor = Colors.red}) =>
    SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );
String getTimeDifference(DateTime notificationDate) {
  final now = DateTime.now();
  final difference = now.difference(notificationDate);

  if (difference.inDays > 0) {
    return '${difference.inDays} أيام';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ساعات';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} دقيقة';
  } else {
    return 'الآن';
  }
}

String getAvailableTimeDifference(String? date) {
  if (date == null) {
    return "الآن"; // "Now" in Arabic
  }

  final now = DateTime.now();
  final availableTime = DateTime.parse(date);
  final difference = now.difference(availableTime);

  if (availableTime.isAfter(now)) {
    // If availableTime is in the future, return the formatted difference
    return 'العميل يحتاجك الساعة ${DateFormat('hh:mm a').format(availableTime)}';
    // Modify the return statement to the desired format
  } else {
    return "العميل يحتاجك الآن"; // "Now" in Arabic
  }
}

extension AppSnackbar on AppKeys {
  static show(snackBar) {
    AppKeys.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    AppKeys.scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}

extension ContextExtension on BuildContext {
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension DisplayAmountExtension on double {
  // 0 -> 0
  // 10 -> 10
  // 123 -> 123
  // 1230 -> 1,230
  // 12300 -> 12,300
  // 123040 -> 123,040
  // 750200.2356 -> 750,200.23
  // 12k -> 12k
  // 12  -> 12
  toFixedAmount() {
    return toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

Future<bool> showDialogForRequestPermission(
  BuildContext context, {
  String? title,
  String? desc,
  void Function()? onAccept,
  void Function()? onDenied,
}) async {
  return await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('الكشف عن الوصول إلى الموقع'),
          content: const Text(
              'يحتاج هذا التطبيق إلى الوصول إلى موقعك في الخلفية لكي نتمكن من ايصالك بأقرب الطلبات لديك. هل توافق علي ذلك'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('الغاء'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop(true); // User agrees.
              },
              child: const Text('موافق'),
            ),
          ],
        );
      });
}

showAlertDialog(context) => showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('تم رفضك لاذن الوصول الي العنوان'),
        content: const Text(
            'يحتاج هذا التطبيق إلى الوصول إلى موقعك في الخلفية لكي نتمكن من ايصالك بأقرب الطلبات لديك. هل توافق على تقديم إذن الموقع في الخلفية؟'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('الغاء'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text('الاعدادات'),
          ),
        ],
      ),
    );
