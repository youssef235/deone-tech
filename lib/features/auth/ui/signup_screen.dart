import 'dart:io';

import 'package:wasq_tech/features/auth/data/model/user.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/app_keys.dart';
import '../../../app/routes.dart';
import '../../../app/widgets/animation/shimmer/shimmer_loading_anim.dart';
import '../../../app/widgets/text_field.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/utils.dart';
import '../data/providers/auth_provider.dart';
import 'package:path/path.dart' as path;

class RegisterScreen extends StatefulHookConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _userImageController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _userSTCController = TextEditingController();
  final TextEditingController _userIbanController = TextEditingController();
  // final TextEditingController _nameController = TextEditingController();
  String? selectedValue;
  XFile? pickedImage;
  XFile? pickedID;
  List<Service> selectedChoices = []; // List to hold selected choices
  List<int> selectedIDs = []; // List to hold selected choices
  final List<String> items = [
    'البنك الأهلي السعودي',
    'مصرف الراجحي',
    'بنك الرياض',
    'البنك العربي الوطني',
    'مصرف الإنماء',
    'البنك السعودي الفرنسي',
    'بنك سعودي للاستثمار',
    'بنك الجزيرة',
    'بنك البلاد',
    'بنك الخليج الدولي السعودية',
    'بنك STC',
    'البنك السعودي',
    'بنك دال 360',
  ];

  String? selectedBank;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      ref.read(authNotifierProvider.notifier).getServices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider.select((value) => value.errorMessage),
        (previous, nextErrorMessage) {
      if (nextErrorMessage != null && nextErrorMessage != '') {
        AppSnackbar.show(buildSnackBar(text: nextErrorMessage));
      }
    });
    return SafeArea(
      child: Scaffold(
        key: AppKeys.registerScaffoldKey,
        body: ShimmerLoadingAnim(
          isLoading: auth.registerLoading,
          child: Form(
            key: AppKeys.registerFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            // AppAssets.recLogo,
                            "res/assets/d1.png",
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                          if (pickedImage != null)
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(pickedImage!.path)),
                                ),
                              ),
                            ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Text(
                        'إنشاء حساب',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'لديك حساب بالفعل؟',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'تسجيل دخول!',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: auth.servicesResponse.services!.map((option) {
                          return ChoiceChip(
                            label: Text(
                              option.name ?? '',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: selectedChoices.contains(option)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            selected: selectedChoices.contains(option),
                            selectedColor: AppColors.primaryColor,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  // Clear all selections and add the current one
                                  selectedChoices.clear();
                                  selectedIDs.clear();
                                  selectedChoices.add(option);
                                  selectedIDs.add(option.id ?? 0);
                                } else {
                                  // Deselect the option
                                  selectedChoices.remove(option);
                                  selectedIDs.remove(option.id);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      AppTextField(
                        controller: _userNameController,
                        hintText: 'الإسم بالكامل',
                        textDirection: TextDirection.rtl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لا يمكنك ترق حقل الإسم فارغا';
                          }

                          return null;
                        },
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff7C7C7C)),
                        suffixIcon: Image.asset(AppAssets.profileIcon),
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      AppTextField(
                        controller: _mobileController,
                        textInputType: TextInputType.phone,
                        hintText: 'رقم الجوال',
                        validator: (value) {
                          if (value == null) {
                            return 'من فضلك ادخل رقم هاتف صحيح';
                          }
                          if (value.isEmpty || value.length < 9) {
                            return 'من فضلك ادخل رقم هاتف صحيح';
                          }
                          return null;
                        },
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
                        // controller: _phoneTextController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      InkWell(
                        onTap: () async {



                          ImagePicker pickerServiceCoverImage = ImagePicker();
                          XFile? pickedImg = await pickerServiceCoverImage
                              .pickImage(source: ImageSource.gallery);
                          if (pickedImg != null) {
                            setState(() {
                              pickedImage = pickedImg;
                              _userImageController.text =
                                  path.basename(pickedImage!.path);
                            });
                          } else {
                            setState(() {
                              pickedImage = null;
                              _userImageController.text = "";
                            });
                          }
                        },
                        child: IgnorePointer(
                          child: AppTextField(
                            controller: _userImageController,
                            textInputType: TextInputType.phone,
                            hintText: 'رفع صوره شخصية',
                            validator: (value) {
                              // if (value == null) {
                              //   return 'من فضلك قم برفع صورة شخصية';
                              // }
                              // if (value.isEmpty) {
                              //   return 'من فضلك قم برفع صورة شخصية';
                              // }
                              return null;
                            },
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff7C7C7C),
                            ),
                            suffixIcon: Image.asset(
                              AppAssets.uploadIcon,
                              width: 15,
                            ),
                            color: Colors.transparent,
                            // controller: _phoneTextController,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      InkWell(
                        onTap: () async {
                          ImagePicker pickerServiceCoverImage = ImagePicker();
                          XFile? pickedImg = await pickerServiceCoverImage
                              .pickImage(source: ImageSource.gallery);

                          if (pickedImg != null) {
                            setState(() {
                              pickedID = pickedImg;
                              _userIdController.text =
                                  path.basename(pickedID!.path);
                            });
                          } else {
                            setState(() {
                              pickedID = null;
                              _userIdController.text = "";
                            });
                          }
                        },
                        child: IgnorePointer(
                          child: AppTextField(
                            controller: _userIdController,
                            textInputType: TextInputType.phone,
                            hintText: 'رفع صوره الهوية',
                            validator: (value) {

                              return null;
                            },
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff7C7C7C),
                            ),
                            suffixIcon: Image.asset(
                              AppAssets.uploadIcon,
                              width: 15,
                            ),
                            color: Colors.transparent,
                            // controller: _phoneTextController,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xffE8E8E8),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Text(
                              'اخنر بنك',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff7C7C7C),
                              ),
                            ),
                            items: items
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedBank,
                            onChanged: (value) {
                              setState(() {
                                selectedBank = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 200,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'ابحث عن بنك ...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      AppTextField(
                        controller: _userIbanController,
                        textInputType: TextInputType.phone,
                        hintText: 'IBAN (اختياري)',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff7C7C7C),
                        ),
                        suffixIcon: const Icon(
                          Icons.credit_card_outlined,
                          color: Color(0xff7C7C7C),
                        ),
                        color: Colors.transparent,
                        // controller: _phoneTextController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      AppTextField(
                        controller: _userSTCController,
                        textInputType: TextInputType.phone,
                        hintText: 'stc pay (اختياري)',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff7C7C7C),
                        ),
                        suffixIcon: Image.asset(
                          AppAssets.stc,
                          width: 10,
                        ),
                        color: Colors.transparent,
                        // controller: _phoneTextController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      Row(
                        children: <Widget>[
                          Radio<String>(
                            value: 'citizen',
                            activeColor: AppColors.primaryColor,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                          const Text('مواطن'),
                          Radio<String>(
                            value: 'resident',
                            activeColor: AppColors.primaryColor,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                          const Text('مقيم'),
                        ],
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
                              height:
                                  MediaQuery.of(context).size.height * 0.068,
                              decoration: BoxDecoration(
                                color: const Color(0xFF32343D),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  // if (selectedValue == null) {
                                  //   AppSnackbar.show(buildSnackBar(
                                  //       text:
                                  //       'من فضلك اختر اذا ما كنت مواطنا سعوديا ام لا'));
                                  //   return;
                                  // }
                                  if (selectedIDs.isEmpty) {
                                    AppSnackbar.show(buildSnackBar(
                                        text: 'من فضلك اختر تخصصك'));
                                    return;
                                  }
                                  if (AppKeys.registerFormKey.currentState!
                                      .validate()) {
                                    int result = await ref
                                        .read(authNotifierProvider.notifier)
                                        .register(
                                          username: _userNameController.text,
                                          email: _emailController.text,
                                          mobile: _mobileController.text,
                                          residentType: selectedValue ?? "citizen",
                                          imagePath: pickedImage!= null ?
                                              (File(pickedImage!.path)
                                                  .path): null,
                                          idPath:
                                          pickedID!= null ?   File(pickedID!.path).path : null ,
                                          stc: _userSTCController.text,
                                          iban: _userIbanController.text,
                                          services: selectedIDs,
                                          bankName: selectedBank ?? '',
                                        );
                                    if (result != -1) {
                                      final currentContext =
                                          context; // Capture the context
                                      Navigator.pushNamed(currentContext,
                                          Routes.verifyOtpScreen, arguments: {
                                        'phone': _mobileController.text,
                                        'temp_user_id': result
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
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
