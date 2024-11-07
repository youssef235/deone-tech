import 'package:get/route_manager.dart';
import 'package:wasq_tech/utils/hive_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/notifications_handler.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await HiveManager.initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationsHandler().init();


  runApp(const RootApp());
}


