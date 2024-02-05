import 'package:expensetracker/res/colors.dart';
import 'package:flutter/material.dart';

class divider extends StatelessWidget {
  const divider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.grey,
      indent: 10.0,
      endIndent: 10.0,
      height: 50.0,
    );
  }
}
