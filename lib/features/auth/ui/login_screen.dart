import 'package:wasq_tech/app/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/routes.dart';
import '../../../app/widgets/text_field.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/utils.dart';
import '../data/providers/auth_provider.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider.select((value) => value.errorMessage),
        (previous, nextErrorMessage) {
      if (nextErrorMessage != null && nextErrorMessage != '') {
        AppSnackbar.show(buildSnackBar(text: nextErrorMessage));
      }
    });
    return Scaffold(
      body: Form(
        key: AppKeys.loginFormKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    // AppAssets.recLogo,
                    "res/assets/d1.png",
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Text(
                    'دخول',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'ليس لديك حساب؟',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerScreen);
                        },
                        child: const Text(
                          'إنشاء حساب!',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  // Add your text form field here
                  AppTextField(
                    hintText: 'رقم الجوال',
                    textInputType: TextInputType.phone,
                    controller: _phoneController,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff7C7C7C),
                    ),
                    suffixIcon: Image.asset(
                      AppAssets.saFlag,
                      width: 15,
                    ),
                    color: Colors.transparent,
                    validator: (value) {
                      if (value == null) {
                        return 'من فضلك ادخل رقم هاتف صحيح';
                      }
                      if (value.isEmpty || value.length < 9) {
                        return 'من فضلك ادخل رقم هاتف صحيح';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  // Add your login button here
                  auth.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.black,
                        ))
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.893,
                          height: MediaQuery.of(context).size.height * 0.068,
                          decoration: BoxDecoration(
                            color: const Color(0xFF32343D),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (AppKeys.loginFormKey.currentState!
                                  .validate()) {
                                var result = await ref
                                    .read(authNotifierProvider.notifier)
                                    .login(
                                      phone: _phoneController.text,
                                    );
                                if (result == true) {
                                  final currentContext =
                                      context; // Capture the context
                                  Navigator.pushNamed(
                                      currentContext, Routes.verifyOtpScreen,
                                      arguments: {
                                        'phone': _phoneController.text,
                                        'temp_user_id': -1,
                                      });
                                }
                              }
                            },
                            child: const Text(
                              'دخول',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                  // Container(
                  //   alignment: AlignmentDirectional.topEnd,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(
                  //           context, Routes.forgetPasswordScreen);
                  //     },
                  //     child: const Text(
                  //       'نسيت كلمة السر؟',
                  //       style: TextStyle(
                  //         color: AppColors.primaryColor,
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 13,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
