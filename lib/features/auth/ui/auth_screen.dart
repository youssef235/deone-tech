import 'package:wasq_tech/features/auth/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../utils/utils.dart';
import '../../home/ui/navigation_screen.dart';
import '../data/providers/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> getPer() async {
      bool services;
      LocationPermission per;
      services = await Geolocator.isLocationServiceEnabled();

      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied) {
        await Geolocator.requestPermission();
        if (per == LocationPermission.denied ||
            per == LocationPermission.deniedForever) {
          AppSnackbar.show(buildSnackBar(
              text:
                  " اعطي التطبيق صلاحيات الموقع \n لكي تحصل علي الطلبيات القريبة منك"));
        }
      }
    }

    return Consumer(builder: (context, ref, child) {
          getPer();
      return ref.watch(authNotifierProvider.select((value) => value.isLogin)) ==
              true
          ? const NavigationScreen()
          : const LoginScreen();
    });
  }
}
