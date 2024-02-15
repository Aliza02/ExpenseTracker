import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/bloc/notification/notification_bloc.dart';
import 'package:expensetracker/bloc/notification/notification_event.dart';
import 'package:expensetracker/bloc/transactionBloc/transaction_bloc.dart';
import 'package:expensetracker/bloc/transactionBloc/transaction_events.dart';
import 'package:expensetracker/bloc/transactionBloc/transaction_states.dart';
import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/firebase_notifications/firebase_noti.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/widgets/appBar.dart';
import 'package:expensetracker/widgets/category_card.dart';
import 'package:expensetracker/widgets/heading.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:expensetracker/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  Future updatebalance({required int amount}) async {
    DocumentSnapshot snap =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    int updatedBalance = snap['balance'] - amount;
    firestore.collection('users').doc(auth.currentUser!.uid).update({
      'balance': updatedBalance,
    });
  }

  Future addTransaction({
    required String category,
    required int amount,
    required String date,
    required String note,
    required DateTime addTransactionDate,
  }) async {
    try {
      firestore
          .collection('Transactions')
          .doc(auth.currentUser!.uid)
          .set({'add': true});
      firestore
          .collection('Transactions')
          .doc(auth.currentUser!.uid)
          .collection('CategoriesTransactions')
          .doc()
          .set({
        'category': category,
        'amount': amount,
        'date': date,
        'note': note,
        'addTransactionDate': addTransactionDate,
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  int notificationCount = 0;
  @override
  void initState() {
    super.initState();
    firebaseInit(context);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    return SafeArea(
        child: BlocProvider(
      create: (context) => TransactionBloc(),
      child: Scaffold(
          backgroundColor: AppColors.cream,
          appBar: const appBar(),
          body: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const heading(title: 'Add Expense'),
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
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Container(
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
                                                    width: Get.width * 0.8,
                                                    child: textformfield(
                                                      hintText: 'Notes',
                                                      color: AppColors.cream,
                                                      opacity: 0.0,
                                                      isDate: false,
                                                      inputType:
                                                          TextInputType.text,
                                                      controller:
                                                          notesController,
                                                    ),
                                                  ),
                                                  BlocListener<TransactionBloc,
                                                      TransactionStates>(
                                                    listener: (context, state) {
                                                      // TODO: implement listener
                                                      if (state
                                                          is AddLoadingState) {
                                                        Get.back();
                                                        Get.showSnackbar(
                                                            const GetSnackBar(
                                                          backgroundColor:
                                                              AppColors.blue,
                                                          message:
                                                              'Amount has been Added',
                                                          duration: Duration(
                                                              seconds: 2),
                                                        ));
                                                      } else if (state
                                                          is InValidState) {
                                                        Get.showSnackbar(
                                                            GetSnackBar(
                                                          backgroundColor:
                                                              AppColors.blue,
                                                          message: state
                                                              .errorMessage,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2),
                                                        ));
                                                      }
                                                    },
                                                    child: SizedBox(
                                                      width: Get.width * 0.4,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                AppColors.blue
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
                                                          onPressed: () async {
                                                            BlocProvider.of<
                                                                        TransactionBloc>(
                                                                    context)
                                                                .add(
                                                              AddTransactionEvent(
                                                                  amount:
                                                                      amountController
                                                                          .text,
                                                                  date:
                                                                      dateController
                                                                          .text,
                                                                  notes:
                                                                      notesController
                                                                          .text),
                                                            );
                                                            // Get.back();
                                                            updatebalance(
                                                              amount: int.parse(
                                                                amountController
                                                                    .text,
                                                              ),
                                                            );
                                                            addTransaction(
                                                              category: category[
                                                                      index]
                                                                  .toString(),
                                                              amount: int.parse(
                                                                  amountController
                                                                      .text),
                                                              date:
                                                                  dateController
                                                                      .text,
                                                              note:
                                                                  notesController
                                                                      .text,
                                                              addTransactionDate:
                                                                  DateTime
                                                                      .now(),
                                                            );

                                                           
                                                          },
                                                          child: text(
                                                              title: 'Add',
                                                              fontSize:
                                                                  Get.width *
                                                                      0.04,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .cream)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CategoryCard(
                                    categoryIconPath:
                                        categoryIcon[index].toString(),
                                    categoryName: category[index].toString(),
                                    cardColor: Colors.transparent,
                                    elementColor: AppColors.blue,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )),
    ));
  }
}
