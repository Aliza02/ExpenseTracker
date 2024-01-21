import 'dart:ffi';

import 'package:expensetracker/bloc/onboardingBloc/transactionTileBloc/transactionTile_bloc.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/widgets/appBar.dart';
import 'package:expensetracker/widgets/heading.dart';
import 'package:expensetracker/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const TransactionTile();
                  },
                ),
              ),
            ],
          )),
    );
  }
}
