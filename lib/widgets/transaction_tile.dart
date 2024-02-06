import 'package:expensetracker/bloc/onboardingBloc/transactionTileBloc/transactionTile_bloc.dart';
import 'package:expensetracker/bloc/onboardingBloc/transactionTileBloc/transactionTile_states.dart';
import 'package:expensetracker/res/icons.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../res/colors.dart';

class TransactionTile extends StatelessWidget {
  final String category;
  final String notes;
  final int amount;
  const TransactionTile(
      {super.key,
      required this.category,
      required this.notes,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    Map<String, String> icons = {
      'Education': "assets/icons/education.png",
      'Bill': "assets/icons/bill.png",
      'Entertainment': 'assets/icons/entertainment.png',
      'Travel': 'assets/icons/travel.png',
      'Health': 'assets/icons/health.png',
      'Shopping': 'assets/icons/shopping-bag.png',
      'Transport': 'assets/icons/transport.png',
      'Food': 'assets/icons/food.png',
      'Others': 'assets/icons/others.png',
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.04,
        vertical: Get.height * 0.013,
      ),
      child: Container(
        height: Get.height * 0.1,
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(Get.width * 0.02),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.6, 1),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 1.8,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.035,
              ),
              child: Image.asset(icons["$category"].toString(),
                  height: 35.0, color: AppColors.blue),
            ),
            SizedBox(
              width: Get.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                    title: category,
                    fontSize: Get.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                  ),
                  text(
                    title: notes,
                    fontSize: Get.width * 0.04,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width * 0.08,
            ),
            const Icon(
              Icons.arrow_upward,
              color: Color(0xFFFc06c84),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0),
              child: text(
                title: amount.toString(),
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFc06c84),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
