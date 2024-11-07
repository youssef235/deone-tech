import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/widgets/text_field.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../data/providers/auth_provider.dart';

class WaitingScreen extends StatefulHookConsumerWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WaitingScreen> createState() =>
      _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      extendBodyBehindAppBar: true,// Set the background color
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -90,
            child: Transform.rotate(
              angle:
              350 * 3.1415926535 / 180, // Rotate by 45 degrees (in radians)
              child: Opacity(
                opacity: 1, // 35% opacity
                child: Image.asset(
                  AppAssets.loginBg,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width *
                      1.2, // Set to screen width
                  // height: MediaQuery.of(context).size.height, // Set to screen height
                ),
              ),
            ),
          ),
          // Centered logo at the top of the page
          // Positioned(
          //   top: MediaQuery.of(context).size.height *
          //       0.15, // Adjust the top position as needed
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Opacity(
          //       opacity: 1.0, // 100% opacity
          //       child: Image.asset(
          //         AppAssets.recLogo,
          //         width: MediaQuery.of(context).size.width *
          //             0.5, // Adjust the size as needed
          //       ),
          //     ),
          //   ),
          // ),
          // // White container with curved edges and your content
          Positioned(
            top: 200, // Adjust the top position as needed
            left: 20, // Adjust the left position as needed
            right: 20, // Adjust the right position as needed
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // physics: const NeverScrollableScrollPhysics(),
              // padding:
              //     EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.of(context).size.height* 0.06),
              children: [
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.99),
                      borderRadius: BorderRadius.circular(29),
                    ),

                    width: MediaQuery.of(context).size.width * 0.89,
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    padding:
                    const EdgeInsets.only( left: 25, right: 25),
                    child: Center(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40,),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                AppAssets.recLogo,
                                width: MediaQuery.of(context).size.width *
                                    0.5, // Adjust the size as needed
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          const Center(
                            child: Text(
                              'مرحبا بك',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Color(0xff434858)),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Center(
                            child: Text(
                              ref.read(authNotifierProvider).user?.name??"",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            'تم إرسال طلبك بنجاح سيتم مراجعة بياناتك',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xff434858)),
                          ),
                          Text(
                            ' وتفعيل حسابك بأقرب وقت',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xff434858)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
