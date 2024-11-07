import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_notification/in_app_notification.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import 'app_keys.dart';
import 'routes.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('ar', '')],
      path: Constants.localizationPath,
      child: const ProviderScope(child: App()),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // AppConfig.setEnvironment(Environment.PROD);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: InAppNotification(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              key: AppKeys.appKey,
              navigatorKey: AppKeys.appKeyNavigator,
              scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
              title: Constants.appTitle,
              theme: CustomTheme.lightTheme,
              initialRoute: Routes.initRoute,
              // routes: Routes.appRoutes,
              onGenerateRoute: Routes.generateRoute,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
            ),
          ),
        );
      },
    );
  }
}
//flutter pub run easy_localization:generate
//flutter pub run easy_localization:generate --source-dir ./res/i18n

//flutter pub run easy_localization:generate --source-dir ./res/i18n -f keys -o locale_keys.g.dart
