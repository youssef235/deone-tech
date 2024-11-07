import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class whiteButtonTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final small;
  final bool? iconLeft;
  final BuildContext context;
  final Function()? pressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const whiteButtonTile(
      {this.iconLeft,
      this.color,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.icon,
      required this.title,
      required this.context,
      required this.pressed,
      super.key,
      this.small});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.small != null
          ? MediaQuery.of(context).size.width * 0.863 / 2
          : MediaQuery.of(context).size.width * 0.893,
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
        color: color == null ? AppColors.white : color,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [BoxShadow(
        //   color: const Color.fromARGB(255, 206, 206, 206) ,
        //   blurRadius: 5  ,
        //   spreadRadius: 1 ,
        // )]
        // border: Border.all(
        //   color: Color.fromARGB(255, 165, 49, 49), width: 2

        // )
      ),
      child: TextButton(
        onPressed: pressed,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: unnecessary_const
            Center(
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: this.fontSize == null ? 16 : this.fontSize,
                  color: textColor != null
                      ? textColor
                      : color == AppColors.primaryColor ||
                              color == AppColors.blackGrey
                          ? AppColors.white
                          : Color.fromARGB(255, 0, 0, 0),
                  fontWeight: this.fontWeight == null
                      ? FontWeight.bold
                      : this.fontWeight,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: iconLeft == true
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Icon(
                  size: 30,
                  this.icon,
                  color: color == AppColors.primaryColor ||
                          color == AppColors.blackGrey||
                          color == AppColors.green6E ||
                          color == AppColors.red
                      ? Colors.white
                      : AppColors.primaryColor, // Icon color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GreyButtonTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final small;
  final bool? iconLeft;
  final BuildContext context;
  final Function()? pressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const GreyButtonTile(
      {this.iconLeft,
      this.color,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.icon,
      required this.title,
      required this.context,
      required this.pressed,
      super.key,
      this.small});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.small != null
          ? MediaQuery.of(context).size.width * 0.863 / 2
          : MediaQuery.of(context).size.width * 0.893,
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: pressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ignore: unnecessary_const
            Text(
              this.title,
              style: TextStyle(
                fontSize: this.fontSize == null ? 16 : this.fontSize,
                color: textColor ?? (color == AppColors.primaryColor ||
                            color == AppColors.blackGrey
                        ? AppColors.white
                        : Color.fromARGB(255, 0, 0, 0)),
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              size: 30,
              this.icon,
              color: color == AppColors.primaryColor ||
                      color == AppColors.blackGrey
                  ? Colors.white
                  : AppColors.primaryColor, // Icon color
            ),
          ],
        ),
      ),
    );
  }
}
