import 'package:expensetracker/bloc/notification/notification_bloc.dart';
import 'package:expensetracker/bloc/notification/notification_event.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/widgets/heading.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class notifications extends StatelessWidget {
  const notifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var argument = Get.arguments;
    String title = argument[0];
    String message = argument[1];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.cream,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<NotificationBloc>(context)
                    .add(ClearNotification());
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.blue,
              )),
        ),
        body: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const heading(title: 'Notifications'),
              title.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.height * 0.02,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.02,
                      ),
                      // height: Get.height * 0.,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        // color: AppColors.blue.withOpacity(0.1),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            title: title,
                            fontSize: Get.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue,
                          ),
                          text(
                            title: message,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.normal,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: text(
                        title: 'No Notifications',
                        fontSize: Get.width * 0.06,
                        fontWeight: FontWeight.normal,
                        color: AppColors.blue,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
