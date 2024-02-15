import 'package:expensetracker/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  final String categoryIconPath;
  final String categoryName;
  final Color cardColor;
  final Color elementColor; // element of child i.e: image and text
  const CategoryCard(
      {super.key,
      required this.categoryIconPath,
      required this.categoryName,
      required this.cardColor,
      required this.elementColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: cardColor,
      child: Column(
        children: [
          Image.asset(
            categoryIconPath,
            height: Get.width * 0.09,
            color: elementColor,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          text(
            title: categoryName,
            fontSize: Get.width * 0.041,
            fontWeight: FontWeight.w400,
            color: elementColor,
          ),
        ],
      ),
    );
  }
}
