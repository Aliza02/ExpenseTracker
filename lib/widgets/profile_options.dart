import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:expensetracker/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileOptions extends StatelessWidget {
  final String optionTitle;
  final IconData icon;
  final int amount;
  final String name;
  const ProfileOptions(
      {super.key,
      required this.optionTitle,
      required this.icon,
      required this.amount,
      required this.name});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(
            title: optionTitle,
            fontSize: Get.width * 0.05,
            fontWeight: FontWeight.normal,
            color: AppColors.grey,
          ),
          InkWell(
            onTap: optionTitle == 'Logout' || optionTitle == 'History'
                ? null
                : () async {
                    if (optionTitle == 'Amount') {
                      print(amount);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.blue,
                              icon: const Icon(
                                Icons.add,
                                color: AppColors.cream,
                              ),
                              title: text(
                                title: 'Add Amount',
                                fontSize: Get.width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cream,
                              ),
                              content: SizedBox(
                                height: Get.height * 0.2,
                                child: Column(
                                  children: [
                                    textformfield(
                                        hintText: 'Amount',
                                        color: AppColors.blue,
                                        opacity: 0.0,
                                        isDate: false,
                                        inputType: TextInputType.number,
                                        controller: controller),
                                    SizedBox(
                                      width: Get.width * 0.4,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.blue.withOpacity(0.3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: () async {
                                            print(amount);
                                            print(controller.text);

                                            await firestore
                                                .collection('users')
                                                .doc(auth.currentUser!.uid)
                                                .update({
                                              'balance': amount +
                                                  int.parse(controller.text)
                                            });
                                            controller.clear();
                                            Get.back();
                                            Get.showSnackbar(const GetSnackBar(
                                              backgroundColor: AppColors.blue,
                                              message: 'Amount has been Added',
                                              duration: Duration(seconds: 2),
                                            ));
                                          },
                                          child: text(
                                              title: 'Add',
                                              fontSize: Get.width * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.cream)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (optionTitle == 'Change Name') {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.blue,
                              icon: const Icon(
                                Icons.person,
                                color: AppColors.cream,
                              ),
                              title: text(
                                title: 'Change User Name',
                                fontSize: Get.width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cream,
                              ),
                              content: SizedBox(
                                height: Get.height * 0.2,
                                child: Column(
                                  children: [
                                    textformfield(
                                        hintText: 'User Name',
                                        color: AppColors.blue,
                                        opacity: 0.0,
                                        isDate: false,
                                        inputType: TextInputType.text,
                                        controller: controller),
                                    SizedBox(
                                      width: Get.width * 0.4,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.blue.withOpacity(0.3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: () async {
                                            Get.back();
                                            await firestore
                                                .collection('users')
                                                .doc(auth.currentUser!.uid)
                                                .update({
                                              'name': controller.text,
                                            });
                                            user?.updateDisplayName(
                                                controller.text);
                                            Get.showSnackbar(const GetSnackBar(
                                              backgroundColor: AppColors.blue,
                                              message:
                                                  'User Name has been changed.',
                                              duration: Duration(seconds: 2),
                                            ));
                                          },
                                          child: text(
                                              title: 'Change',
                                              fontSize: Get.width * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.cream)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  },
            child: Icon(
              icon,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
