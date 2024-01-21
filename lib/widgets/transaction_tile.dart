import 'package:expensetracker/bloc/onboardingBloc/transactionTileBloc/transactionTile_bloc.dart';
import 'package:expensetracker/bloc/onboardingBloc/transactionTileBloc/transactionTile_states.dart';
import 'package:expensetracker/res/icons.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../res/colors.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> abc = [
      'Entertainment',
      'Education',
      'Food',
      'Health',
      'Shopping',
      'Travel',
      'Other'
    ];
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
              child: Image.asset(AppIcons.education,
                  height: 50.0, color: AppColors.blue),
            ),
            SizedBox(
              width: Get.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  text(
                      title: 'Education',
                      fontSize: Get.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                      ),
                      
                  text(
                    title: 'Stationary and Books',
                    fontSize: Get.width * 0.04,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blue,
                  ),

                ],
              ),
            ),
            // Spacer(
            //   flex: 1,
            // ),
            SizedBox(
              width: Get.width * 0.08,
            ),
            const Icon(
              Icons.arrow_upward,
              color: AppColors.blue,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0),
              child: text(
                title: '4000',
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.w500,
                color: AppColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
