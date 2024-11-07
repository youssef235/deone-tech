import 'package:wasq_tech/theme/app_colors.dart';
import 'package:wasq_tech/utils/utils.dart';
import 'package:flutter/material.dart';

class ButtonData {
  String name;
  IconData iconData;
  Function() pressed;
  String? value;
  ButtonData(
      {required this.name,
      required this.pressed,
      required this.iconData,
      this.value});
}

Future<String?> showTextInputDialog(
  BuildContext context,
) async {
  return showDialog(
      context: context,
      builder: (context) {
        TextEditingController _textFieldController = TextEditingController();
        GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        return Container(
          width: double.infinity,
          child: AlertDialog(
            title: const Text('شكوي او اقتراح'),
            content: Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                // margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: AppColors.grayWhite), // Add a border
                ),
                height: 100.0, // Fixed height
                child: SingleChildScrollView(
                  // Add a SingleChildScrollView for scrolling
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _textFieldController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك اكتب هنا';
                        }
                        return null;
                      },
                      maxLines: null, // Allow multiple lines for notes
                      decoration: const InputDecoration(
                        hintText: 'من فضلك اكتب هنا',
                        border:
                            InputBorder.none, // Remove the default input border
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                  ),
                  child: const Text('تقديم'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AppSnackbar.show(buildSnackBar(
                          text: "تم الارسال", backgroundColor: Colors.green));
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      });
}
