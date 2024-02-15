import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/widgets/appBar.dart';
import 'package:expensetracker/widgets/heading.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:expensetracker/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.cream,
          appBar: const appBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const heading(title: 'All Transactions'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      color: AppColors.grey.withOpacity(0.35),
                    ),
                    text(
                      title: 'Newest to Oldest',
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey.withOpacity(0.35),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: firestore
                      .collection('Transactions')
                      .doc(auth.currentUser!.uid)
                      .collection('CategoriesTransactions')
                      .orderBy('addTransactionDate', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap = snapshot.data!.docs[index];
                            return TransactionTile(
                              amount: snap['amount'],
                              category: snap['category'],
                              notes: snap['note'],
                            );
                          },
                        ),
                      );
                    }
                  }),
            ],
          )),
    );
  }
}
