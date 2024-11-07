import 'dart:async';

import 'package:in_app_notification/in_app_notification.dart';
import 'package:wasq_tech/app/notifications_handler.dart';
import 'package:wasq_tech/app/routes.dart';
import 'package:wasq_tech/features/auth/data/providers/auth_provider.dart';
import 'package:wasq_tech/features/notifications/data/providers/notification_provider.dart';
import 'package:wasq_tech/theme/app_assets.dart';
import 'package:wasq_tech/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/tracking.dart';
import '../../../app/widgets/notification_body.dart';
import '../../Notifications/ui/notifications_screen.dart';
import '../../more/ui/more_screen.dart';
import '../data/providers/home_provider.dart';
import 'home_screen.dart';

class NavigationScreen extends StatefulHookConsumerWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen>
    with AutomaticKeepAliveClientMixin {
  final List<Widget> _children = [
    const HomeScreen(),
    const NotificationsScreen(),
    const MoreScreen()
  ];
  StreamSubscription<PushNotificationEvent>? _notificationSubscription;

  @override
  initState() {
    Future.delayed(const Duration(seconds: 0), () {
      LocationService locationService = LocationService();
      locationService.startTracking(ref.read(authNotifierProvider).user);
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (proposal_id != null) {
        navigateToProposal(proposal_id!);
      }
    });

    super.initState();
    _notificationSubscription =
        eventBus.on<PushNotificationEvent>().listen((event) async {
      if (event.notificationMessage.data.isNotEmpty &&
          event.notificationMessage.data['project_id'] != null) {
        int id = int.parse(event.notificationMessage.data['project_id']);
        event.notificationMessage.data['project_id'] = null;
        navigateToProposal(id);
      }
        print("############################################");
        print(event.notificationMessage.title);
        print(event.notificationMessage.data);

        InAppNotification.show(
          duration: const Duration(seconds: 2),
          child: NotificationBody(
              title: event.notificationMessage.title??'',
              body: event.notificationMessage.body??''),
          context: context,
          onTap: () {
            InAppNotification.dismiss(context: context);
          },
        );


    });
    // await  Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel(); // Cancel the subscription
    super.dispose();
  }

  navigateToProposal(int proposalID) async {
    var proposal = await ref
        .read(notificationsNotifierProvider.notifier)
        .getProposal(proposalID);
    if (proposal != null) {
      Navigator.pushNamed(context, Routes.notificationItem,
          arguments: proposal);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final homeProvider = ref.watch(homeNotifierProvider);

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 10, // Blur radius
              offset: const Offset(0, 3), // Offset from top
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              unselectedItemColor: Colors.black,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed, // Disable animation

              currentIndex: homeProvider.screenIndex,
              onTap: onTabTapped,
              items: [
                BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        ref.read(homeNotifierProvider).screenIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.grayWhite,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        AppAssets.homeIcon,
                        width: 26, // Specify the width
                        height: 26, // Specify the height
                      ),
                    ),
                    label: "الطلبات"),
                BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        ref.read(homeNotifierProvider).screenIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.grayWhite,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        AppAssets.notificationIcon,
                        width: 26, // Specify the width
                        height: 26, // Specify the height
                      ),
                    ),
                    label: "طلباتك"),
                BottomNavigationBarItem(
                    icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          ref.read(homeNotifierProvider).screenIndex == 2
                              ? AppColors.primaryColor
                              : AppColors.grayWhite,
                          BlendMode.srcIn,
                        ),
                        child: const Icon(Icons.settings)),
                    label: "الاعدادات"),
              ]),
        ),
      ),
      body: _children[homeProvider.screenIndex],
    );
  }

  void onTabTapped(int index) {
    ref.read(homeNotifierProvider.notifier).changePageIndex(index);
  }

  @override
  bool get wantKeepAlive => true;
}
