import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/widgets/category_card.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:expensetracker/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/icons.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  List<String> category = [
    'Entertainment',
    'Bill',
    'Travel',
    'Health',
    'Education',
    'Shopping',
    'Transport',
    'Food',
    'Others',
  ];

  List<String> categoryIcon = [
    AppIcons.entertainment,
    AppIcons.bills,
    AppIcons.travel,
    AppIcons.health,
    AppIcons.education,
    AppIcons.shopping,
    AppIcons.transport,
    AppIcons.food,
    AppIcons.others,
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black.withOpacity(0.6),
                  size: 30.0,
                ),
              ),
            ),
            body: SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                    ),
                    child: text(
                      title: 'Add Expense',
                      fontSize: Get.width * 0.08,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.6),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, RowIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(3, (index) {
                                if (RowIndex == 1) {
                                  index += 3;
                                } else if (RowIndex == 2) {
                                  index += 6;
                                } else {
                                  index = index;
                                }

                                return Container(
                                  width: Get.width * 0.3,
                                  margin: EdgeInsets.only(
                                    left: Get.width * 0.025,
                                  ),
                                  child: InkWell(
                                    splashColor: AppColors.cream,
                                    borderRadius: BorderRadius.circular(
                                      Get.width * 0.03,
                                    ),
                                    onTap: () {
                                      showBottomSheet(
                                          enableDrag: true,
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: Get.height * 0.6,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                color: AppColors.blue,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      Get.width * 0.06),
                                                  topRight: Radius.circular(
                                                      Get.width * 0.06),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: Get.height * 0.02,
                                                    width: Get.width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.grey
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Get.width * 0.03,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.1,
                                                      ),
                                                      Container(
                                                        width: Get.width * 0.3,
                                                        margin: EdgeInsets.only(
                                                          left:
                                                              Get.width * 0.15,
                                                        ),
                                                        child: text(
                                                          title: 'Category',
                                                          fontSize:
                                                              Get.width * 0.06,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color:
                                                              AppColors.cream,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: Get.width * 0.5,
                                                        margin: EdgeInsets.only(
                                                          // right:
                                                          //     Get.width * 0.04,
                                                          top:
                                                              Get.height * 0.03,
                                                        ),
                                                        child: CategoryCard(
                                                          categoryIconPath:
                                                              categoryIcon[
                                                                      index]
                                                                  .toString(),
                                                          categoryName:
                                                              category[index]
                                                                  .toString(),
                                                          cardColor:
                                                              AppColors.blue,
                                                          elementColor:
                                                              AppColors.cream,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.8,
                                                    child: textformfield(
                                                      hintText: 'Amount',
                                                      color: AppColors.cream,
                                                      opacity: 0.0,
                                                      isDate: false,
                                                      inputType:
                                                          TextInputType.number,
                                                      controller:
                                                          amountController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.8,
                                                    child: textformfield(
                                                      hintText: 'Date',
                                                      color: AppColors.cream,
                                                      isDate: true,
                                                      opacity: 0.0,
                                                      inputType:
                                                          TextInputType.none,
                                                      controller:
                                                          dateController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.4,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColors
                                                                  .blue
                                                                  .withOpacity(
                                                                      0.3),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                        child: text(
                                                            title: 'Add',
                                                            fontSize:
                                                                Get.width *
                                                                    0.04,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .cream)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: CategoryCard(
                                      categoryIconPath:
                                          categoryIcon[index].toString(),
                                      categoryName: category[index].toString(),
                                      cardColor: Colors.transparent,
                                      elementColor: AppColors.black,
                                    ),
                                  ),
                                );
                              }),

                              // Container(
                              //   width: Get.width * 0.2,
                              //   margin: EdgeInsets.only(
                              //     left: Get.width * 0.03,
                              //   ),
                              //   child: Card(
                              //     elevation: 0.0,
                              //     child: Column(
                              //       children: [
                              //         Image.asset(
                              //           AppIcons.entertainment,
                              //           height: Get.width * 0.08,
                              //         ),
                              //         Text('Entertainment'),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Expanded(
                              //   child: ListView.builder(
                              //       shrinkWrap: true,

                              //       itemCount: 2,
                              //       itemBuilder: (context, index) {
                              //         return Text('abc');
                              //         //  Container(
                              //         //   width: Get.width * 0.2,
                              //         //   margin: EdgeInsets.only(
                              //         //     left: Get.width * 0.03,
                              //         //   ),
                              //         //   child: Card(
                              //         //     elevation: 0.0,
                              //         //     child: Column(
                              //         //       children: [
                              //         //         Image.asset(
                              //         //           AppIcons.entertainment,
                              //         //           height: Get.width * 0.08,
                              //         //         ),
                              //         //         Text('Entertainment'),
                              //         //       ],
                              //         //     ),
                              //         //   ),
                              //         // );
                              //       }),
                              // ),

                              // Container(
                              //   margin: EdgeInsets.only(
                              //     left: Get.width * 0.03,
                              //   ),
                              //   child: Card(
                              //     elevation: 0.0,
                              //     // color: AppColors.cream,
                              //     // shadowColor: AppColors.grey,
                              //     child: Column(
                              //       children: [
                              //         Image.asset(
                              //           AppIcons.entertainment,
                              //           height: Get.width * 0.08,
                              //         ),
                              //         Text('Entertainment'),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //     left: Get.width * 0.03,
                              //   ),
                              //   child: Card(
                              //     elevation: 0.0,
                              //     // color: AppColors.cream,
                              //     // shadowColor: AppColors.grey,
                              //     child: Column(
                              //       children: [
                              //         Image.asset(
                              //           AppIcons.entertainment,
                              //           height: Get.width * 0.08,
                              //         ),
                              //         Text('Entertainment'),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // ],
                            ),
                          );
                        }),
                  ),

                  // const textformfield(hintText: 'Amount'),
                  // const textformfield(hintText: 'Category'),
                  // const textformfield(hintText: 'Date'),
                ],
              ),
            )));
  }
}
