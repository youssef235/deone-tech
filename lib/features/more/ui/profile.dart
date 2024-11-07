import 'package:cached_network_image/cached_network_image.dart';
import 'package:wasq_tech/app/widgets/text_field.dart';
import 'package:wasq_tech/features/auth/data/providers/auth_provider.dart';
import 'package:wasq_tech/theme/app_assets.dart';
import 'package:wasq_tech/theme/app_colors.dart';
import 'package:wasq_tech/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends StatefulHookConsumerWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState()=> _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with AutomaticKeepAliveClientMixin  {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      ref.read(authNotifierProvider.notifier).getStatics();
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("حسابي" , style: TextStyle(fontSize: 20)),
      ),
      body: Container(
        // margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              // color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(auth.user?.name??""),
                          IconButton(onPressed: (){
                            updateNameDialog(context);
                          }, icon: const Icon(Icons.edit,color: AppColors.primaryColor,))
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          const Text("ID  "),
                          Text(auth.user?.id.toString()??""),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          const Text("تقييمك  "),
                          Text(auth.user?.avg_rate.toString()??""),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(auth.user?.phone??""),
                          IconButton(onPressed: (){
                            updatePhoneDialog(context);
                          }, icon: const Icon(Icons.edit,color: AppColors.primaryColor,))
                        ],
                      ),
                    ],
                  ),
                  ClipOval(
                    child: Container(
                      width: 100, // Adjust the size as needed
                      height: 100, // Should be the same as width to create a circle
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // Change the background color as needed
                      ),
                      // Add your content here
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: auth.user?.personal_image ?? "",
                        placeholder: (context, url) =>
                            Image.asset(AppAssets.recLogo, fit: BoxFit.fitWidth),
                        errorWidget: (context, url, error) =>
                            Image.asset(AppAssets.recLogo, fit: BoxFit.cover),
                      ),
                    ),
                  )

                ],
              ),
            ),

    );
  }
  
  @override
  // TODO: implement wantKeepAlive
    bool get wantKeepAlive => true; 


  Future<String?> updateNameDialog(BuildContext context,) async {
    TextEditingController _userNameController = TextEditingController();
    _userNameController.text=ref.read(authNotifierProvider).user?.name??"";
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            child: AlertDialog(
              title: const Text('تغير الاسم'),
              content: Form(
                key: _formKey,
                child:AppTextField(
                  textDirection: TextDirection.rtl,
                  controller: _userNameController,
                  hintText: 'الإسم بالكامل',
                  validator: (value){
                    if(value==null||value.isEmpty){
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
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    child: const Text('تعديل الاسم'),
                    onPressed:() async {
                      if(_formKey.currentState!.validate())
                      {
                        if(_userNameController.text==ref.read(authNotifierProvider).user?.name){
                          Navigator.pop(context);
                          return;
                        }
                        await ref.read(authNotifierProvider.notifier).updateUser(name: _userNameController.text).then((value){
                          if(value==true){
                            Navigator.pop(context);
                            AppSnackbar.show(buildSnackBar(text: "تم تعديل الاسم بنجاح",backgroundColor: Colors.green));
                          }
                          else{
                            AppSnackbar.show(buildSnackBar(text: "حدث خطأ ما",backgroundColor: Colors.red));
                          }
                        });
                      }

                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<String?> updatePhoneDialog(BuildContext context,) async {
    TextEditingController mobileController = TextEditingController();
    mobileController.text=ref.read(authNotifierProvider).user?.phone??"";
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            child: AlertDialog(
              title: const Text('تغير رقم الجوال'),
              content: Form(
                key: formKey,
                child:AppTextField(
                  controller: mobileController,
                  textInputType: TextInputType.phone,
                  hintText: 'رقم الجوال',
                  validator: (value){
                    if(value==null){
                      return 'من فضلك ادخل رقم هاتف صحيح';
                    }
                    if(value.isEmpty||value.length<9){
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
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    child: const Text('تعديل رقم الجوال'),
                    onPressed:() async {
                      if(formKey.currentState!.validate())
                      {
                        if(mobileController.text==ref.read(authNotifierProvider).user?.name){
                          Navigator.pop(context);
                          return;
                        }
                        await ref.read(authNotifierProvider.notifier).updateUser(phone: mobileController.text).then((value){
                          if(value==true){
                            Navigator.pop(context);
                            AppSnackbar.show(buildSnackBar(text: "تم تعديل الاسم بنجاح",backgroundColor: Colors.green));
                          }
                          else{
                            AppSnackbar.show(buildSnackBar(text: "حدث خطأ ما",backgroundColor: Colors.red));
                          }
                        });
                        // if(result!=null&&result.toString().isNotEmpty){
                        //   AppSnackbar.show(buildSnackBar(text: result.toString(),backgroundColor: Colors.green));
                        //   _textFieldController.clear();
                        //   Navigator.pushNamedAndRemoveUntil(context, Routes.initRoute, (route) => false);
                        // }
                      }

                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

    }
