import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart';

whatsapp(int number) async {
  var androidUrl = "whatsapp://send?phone=$number&text=Hi, I need some help";
  var iosUrl =
      "https://wa.me/$number?text=${Uri.parse('Hi, I need some help')}";

  try {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  } on Exception {
    AppSnackbar.show(buildSnackBar(
        text: "تطبيق الواتس اب غير مثبت", backgroundColor: Colors.red));
  }
}
