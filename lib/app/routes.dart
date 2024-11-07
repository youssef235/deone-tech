import 'package:wasq_tech/features/home/data/models/home_response.dart';
import 'package:flutter/material.dart';
import 'package:wasq_tech/features/invoice/ui/invoice_screen.dart';
import 'package:wasq_tech/features/notifications/data/model/notification_response.dart';

import '../features/auth/ui/auth_screen.dart';
import '../features/auth/ui/forget_password_screen.dart';
import '../features/auth/ui/login_screen.dart';
import '../features/auth/ui/signup_screen.dart';
import '../features/auth/ui/verify_otp_screen.dart';
import '../features/auth/ui/wating.dart';
import '../features/chat/ui/chat_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/home/ui/navigation_screen.dart';
import '../features/home/ui/request_screen.dart';
import '../features/notifications/ui/attachments_screen.dart';
import '../features/notifications/ui/map.dart';
import '../features/notifications/ui/notifications_item_screen.dart';
import '../features/service_form/ui/service_form_screen.dart';

class Routes {
  static const String initRoute = "/";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String verifyOtpScreen = "/verify_otp";
  static const String waiting = "/waiting";
  static const String homeScreen = "/home";
  static const String navigationScreen = "/navigation";
  static const String forgetPasswordScreen = "/forget_password";
  static const String serviceFormScreen = "/service_form";
  static const String notificationItem = "/notification_item";
  static const String requestServiceScreen = "/request_service";
  static const String orderAttachments = "/order_attachments";
  static const String chat = "/chat";
  static const String invoice = "/invoice";
  static const String map = "/map";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case waiting:
        return MaterialPageRoute(builder: (_) => const WaitingScreen());
      case verifyOtpScreen:
        var data = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => VerifyOtpScreen(
                  phoneNumber: data["phone"] as String,
                  temp_user_id: data["temp_user_id"] as int,
                ));
      case forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case navigationScreen:
        return MaterialPageRoute(builder: (_) => const NavigationScreen());
      case notificationItem:
        var data = settings.arguments as Proposals;
        return MaterialPageRoute(
            builder: (_) => NotificationItem(
                  proposal: data,
                ));
      case chat:
        var data = settings.arguments as Proposals;
        return MaterialPageRoute(
            builder: (_) => Chat(
                  proposal: data,
                ));
      case orderAttachments:
        var data = settings.arguments as Projects;
        return MaterialPageRoute(
            builder: (_) => AttachmetsScreen(
                  project: data,
                ));
      case requestServiceScreen:
        var data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => RequestService(
                  project: data["project"],
                  isEdit: data["edit"] as bool,
                ));
      // case invoice:
      //   var data = settings.arguments as Projects;
      //   return MaterialPageRoute(builder: (_) => InvoiceScreen(project: data));
      case map:
        var data = settings.arguments as latlng;
        return MaterialPageRoute(
            builder: (_) => LocationAccess(
                  latitude: data.latitude,
                  longitude: data.longitude,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }

  static Widget buildPage(RouteSettings settings) {
    switch (settings.name) {
      default:
        return const SizedBox.shrink();
    }
  }
}

class latlng {
  double latitude;
  double longitude;
  latlng({required this.latitude, required this.longitude});
}
