import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/widgets/appBar.dart';
import 'package:expensetracker/widgets/divider.dart';
import 'package:expensetracker/widgets/heading.dart';
import 'package:expensetracker/widgets/profile_options.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class profile extends StatelessWidget {
  profile({super.key});
  int balanceAmount = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.cream,
      appBar: const appBar(),
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const heading(title: 'Profile'),
            SizedBox(height: Get.height * 0.01),
            Row(
              children: [
                Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.2,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: Get.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.width),
                    color: AppColors.grey.withOpacity(0.3),
                  ),
                  child: StreamBuilder(
                      stream: firestore
                          .collection('users')
                          .doc(auth.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return text(
                          title: !snapshot.hasData
                              ? ''
                              : '${snapshot.data!['name'].toString()[0]}',
                          color: AppColors.blue,
                          fontSize: Get.width * 0.14,
                          fontWeight: FontWeight.bold,
                        );
                      }),
                ),
                SizedBox(width: Get.width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: firestore
                            .collection('users')
                            .doc(auth.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return text(
                            title: !snapshot.hasData
                                ? ''
                                : '${snapshot.data!['name']}',
                            fontSize: Get.width * 0.05,
                            fontWeight: FontWeight.normal,
                            color: AppColors.grey,
                          );
                        }),
                    StreamBuilder(
                        stream: firestore
                            .collection('users')
                            .doc(auth.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            balanceAmount = snapshot.data!['balance'];
                          }
                          return text(
                            title: !snapshot.hasData
                                ? 'Rs.0'
                                : 'Rs.${snapshot.data!['balance']}',
                            fontSize: Get.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue,
                          );
                        }),
                  ],
                ),
              ],
            ),
            const divider(),
            ProfileOptions(
              optionTitle: 'Amount',
              amount: balanceAmount,
              name: auth.currentUser!.displayName.toString(),
              icon: Icons.add,
            ),
            const divider(),
            ProfileOptions(
              optionTitle: 'Change Name',
              amount: balanceAmount,
              name: auth.currentUser!.displayName.toString(),
              icon: Icons.edit,
            ),
            const divider(),
            ProfileOptions(
              optionTitle: 'History',
              icon: Icons.history,
              amount: balanceAmount,
              name: auth.currentUser!.displayName.toString(),
            ),
            const divider(),
            InkWell(
              onTap: () {
                auth.signOut();
                // Get.offUntil(page, (route) => false)
                try {
                  Get.offAllNamed('/signin');
                } on Exception catch (e) {
                  print(e);
                }
              },
              child: ProfileOptions(
                optionTitle: 'Logout',
                icon: Icons.logout,
                amount: balanceAmount,
                name: auth.currentUser!.displayName.toString(),
              ),
            ),
            const divider(),
          ],
        ),
      ),
    ));
  }
}
