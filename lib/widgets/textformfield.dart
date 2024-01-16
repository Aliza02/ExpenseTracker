import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colors.dart';

class textformfield extends StatelessWidget {
  final String hintText;
  final Color color;
  final double opacity;
  const textformfield(
      {super.key,
      required this.hintText,
      required this.color,
      required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.03,
        vertical: Get.height * 0.015,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.cream,
            fontSize: Get.width * 0.04,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: AppColors.cream,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
