import 'package:expensetracker/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colors.dart';

class heading extends StatelessWidget {
  final String title;
  const heading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.03,
      ),
      child: text(
        title: title,
        fontSize: Get.width * 0.08,
        fontWeight: FontWeight.w500,
        color: AppColors.black.withOpacity(0.6),
      ),
    );
  }
}
