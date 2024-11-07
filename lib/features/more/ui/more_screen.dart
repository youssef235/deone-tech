import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasq_tech/features/more/ui/profile.dart';
import 'package:wasq_tech/features/more/ui/terms_conditions.dart';
import 'package:wasq_tech/features/more/ui/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/widgets/text_field.dart';
import '../../../app/widgets/whatapp_launcher.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/utils.dart';
import '../../auth/data/providers/auth_provider.dart';
import '../../home/data/providers/home_provider.dart';

class MoreScreen extends StatefulHookConsumerWidget {
  const MoreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<MoreScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      ref.read(authNotifierProvider.notifier).getStatics();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);

    List<ButtonData> buttons = [
      ButtonData(
          name: "حسابي",
          iconData: Icons.person,
          pressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }),
      ButtonData(
          name: "الشروط و الاحكام",
          iconData: Icons.policy,
          pressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsConditionsPage()));
          }),
      ButtonData(
          name: "طلباتك",
          value: auth.user!.completed_projects.toString(),
          iconData: Icons.list,
          pressed: () {
            ref.read(homeNotifierProvider.notifier).changePageIndex(1);
          }),
      // ButtonData(
      //     name: "محفظتك",
      //     value: "${auth.user!.balance.toString()} ريال ",
      //     iconData: Icons.wallet,
      //     pressed: () {
      //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsConditionsPage()));
      //     }),
      ButtonData(
          name: "الدعم الفني",
          iconData: Icons.support_agent,
          pressed: () async {
            whatsapp(int.parse("+966533832097"));
          }),
      ButtonData(
          name: "تسجيل الخروج",
          iconData: Icons.logout,
          pressed: () {
            ref.read(homeNotifierProvider.notifier).changePageIndex(0);
            ref.read(authNotifierProvider.notifier).logout();
          }),
      ButtonData(
          name: "حذف الحساب",
          iconData: Icons.delete,
          pressed: () {
            ref.read(homeNotifierProvider.notifier).changePageIndex(0);
            ref.read(authNotifierProvider.notifier).logout();
          }),
    ];

    super.build(context);

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(AppAssets.recLogo,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15),
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.75,
                    // height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: AppColors.blackGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "الاعدادات",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value to change the curvature
              ),
              child: Text(
                "رصيد محفظتك الحالي : ${ref.read(authNotifierProvider).user?.balance} ريال",
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1 / .5,
                      crossAxisCount: 2),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: buttons[index].pressed,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.blackGrey,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(buttons[index].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  const SizedBox(width: 10),
                                  Icon(
                                    buttons[index].iconData,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              if (buttons[index].value != null)
                                Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Text(
                                      buttons[index].value.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ))
                            ],
                          )),
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
