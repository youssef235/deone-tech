import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

import '../features/auth/data/model/user.dart';
import '../theme/app_assets.dart';

class LocationService {
  late LocationSettings locationSettings;
  StreamSubscription<Position>? _positionStreamSubscription;

  LocationService() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "التطبيق سيستمر في تلقي موقعك حتى عندما لا تستخدمه",
          notificationTitle: "تشغيل في الخلفية",
          enableWakeLock: true,
          notificationIcon: AndroidResource(name: "res/assets/logo_rec.png"),

        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
  }

  void startTracking(User? user) {
    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) async {
      print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
      await FirebaseFirestore.instance
          .collection('Tracking')
          .doc (user?.id.toString()??"")
          .set({
            'lat':position!.latitude,
            'long':position.longitude,
            'timestamp':Timestamp.now(),
          }
      );
    });
  }

  void stopTracking() {
    _positionStreamSubscription?.cancel();
  }
}
