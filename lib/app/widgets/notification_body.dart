import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class NotificationBody extends StatelessWidget {
  final String body;
  final String title;
  final double minHeight;

  const NotificationBody({
    Key? key,
    this.body = "",
    this.title = "",
    this.minHeight = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minHeight = math.min(
      this.minHeight,
      MediaQuery.of(context).size.height,
    );
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 12,
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 1.4,
                    color: AppColors.primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          Text(
                            body,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
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