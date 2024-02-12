import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/bloc/notification/notification_bloc.dart';
import 'package:expensetracker/bloc/notification/notification_event.dart';
import 'package:expensetracker/bloc/notification/notification_states.dart';
import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/firebase_notifications/firebase_noti.dart';
import 'package:expensetracker/model/chart_data.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/res/icons.dart';
import 'package:expensetracker/screens/notifications/notifications.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:expensetracker/widgets/transaction_tile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    firebaseInit(context);
  }

  List<ChartData> data = [];
  int spentAmount = 0;
  double spentRatio = 0.0;
  double balance = 0.0;

  int notificationCount = 0;
  Future<double> buildChart() async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();

    await firestore
        .collection('Transactions')
        .doc(auth.currentUser!.uid)
        .collection('CategoriesTransactions')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        spentAmount = element['amount'] + spentAmount;
      });
      print(spentAmount);
      print(snapshot['balance']);
      spentRatio = (spentAmount / snapshot['balance']) * 100;
    });
    print(spentRatio);

    if (snapshot['balance'] <= 10000) {
      await initNotification().then((value) async {
        var data = {
          'to': value.toString(),
          'priority': 'high',
          'notification': {
            'title': 'Low Balance',
            'body': 'Your balance is low. Please Reacharge your account.',
          }
        };

        final result = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAzIotYuQ:APA91bFWThcyd3cRcB24_C2b5ByfdXmiLvPWUAAWw5ijzlINFXWMx9vBvx2msdzAW4AdTuJrb4StfJFyPAjFI3KTU3U1ZBcpUTOVCxNmn21xj6KlV3btw_DmqA48irC2qO7j5-jRd3a4'
          },
        );
        if (result.statusCode == 200) {
          notificationCount++;
          BlocProvider.of<NotificationBloc>(context)
              .add(HasNotification(notificationCount: notificationCount));
        }
      });
    }

    return spentRatio;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: AppColors.cream,
        elevation: 6.0,
        notchMargin: 6.0,
        height: 50.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.18,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/home');
                },
                child: Image.asset(
                  AppIcons.home,
                  height: Get.width * 0.06,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.2,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/allTransactions');
                },
                child: Image.asset(
                  AppIcons.transaction,
                  height: Get.width * 0.06,
                ),
              ),
            ),
            Container(
              width: Get.width * 0.2,
              margin: EdgeInsets.only(
                left: Get.width * 0.15,
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/stats');
                },
                child: Image.asset(
                  AppIcons.stats,
                  height: Get.width * 0.06,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.18,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/profile');
                },
                child: Image.asset(
                  AppIcons.account,
                  height: Get.width * 0.06,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.width),
        ),
        onPressed: () {
          Get.toNamed('/addTransaction');
        },
        backgroundColor: AppColors.blue,
        child: Icon(
          Icons.add,
          color: AppColors.cream,
          size: Get.width * 0.08,
        ),
      ),
      backgroundColor: AppColors.cream,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.45,
            decoration: BoxDecoration(
              color: AppColors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurStyle: BlurStyle.solid,
                  blurRadius: 0.2,
                  spreadRadius: 2.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Get.width * 0.05),
                bottomRight: Radius.circular(Get.width * 0.05),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -80.0,
                  child: Container(
                    width: Get.width * 0.5,
                    height: Get.height * 0.2,
                    margin: EdgeInsets.only(
                      left: Get.width * 0.08,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 24, 51, 82)
                          .withOpacity(0.6),
                      borderRadius: BorderRadius.circular(Get.width),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20.0,
                  right: -10.0,
                  child: Container(
                    width: Get.width * 0.5,
                    height: Get.height * 0.2,
                    margin: EdgeInsets.only(
                      left: Get.width * 0.08,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 24, 51, 82)
                          .withOpacity(0.6),
                      borderRadius: BorderRadius.circular(Get.width),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: Get.height * 0.03,
                                  left: Get.width * 0.065,
                                ),
                                child: Text(
                                  'Welcome!',
                                  style: TextStyle(
                                    fontSize: Get.width * 0.08,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.cream,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (notificationCount > 0) {
                                    Get.to(
                                        () => BlocProvider.value(
                                            value: BlocProvider.of<
                                                NotificationBloc>(
                                              context,
                                            ),
                                            child: const notifications()),
                                        arguments: [
                                          'Low Balance',
                                          'Your balance is low. Please Recharge your account.'
                                        ]);
                                  } else {
                                    Get.to(
                                      () => BlocProvider.value(
                                          value:
                                              BlocProvider.of<NotificationBloc>(
                                            context,
                                          ),
                                          child: const notifications()),
                                      arguments: ['', ''],
                                    );
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: Get.height * 0.03,
                                        right: Get.width * 0.065,
                                      ),
                                      child: Icon(
                                        Icons.notifications,
                                        color: AppColors.cream,
                                        size: Get.width * 0.08,
                                      ),
                                    ),
                                    BlocBuilder<NotificationBloc,
                                            NotificationStates>(
                                        builder: (context, state) {
                                      print(state);
                                      if (state is HasNotificationState) {
                                        return Positioned(
                                          top: Get.height * 0.01,
                                          left: Get.width * 0.03,
                                          child: Container(
                                            width: Get.width * 0.07,
                                            height: Get.height * 0.036,
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                color: Color(0xFFFc06c84),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width),
                                                )),
                                            child: text(
                                              title: state.notificationCount
                                                  .toString(),
                                              fontSize: Get.width * 0.05,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      } else if (state is noNotification) {
                                        print(state);
                                        return Container();
                                      } else {
                                        return Container();
                                      }
                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder(
                              stream: firestore
                                  .collection('users')
                                  .doc(auth.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: Get.width * 0.065,
                                  ),
                                  child: Text(
                                    !snapshot.hasData
                                        ? ' '
                                        : '${snapshot.data!['name']}',
                                    style: TextStyle(
                                      fontSize: Get.width * 0.065,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.cream,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width * 0.9,
                      margin: EdgeInsets.only(
                        top: Get.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(
                          Get.width * 0.04,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(211, 70, 68, 68),
                            blurRadius: 10.0,
                            spreadRadius: 0.5,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: Get.width * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: Get.width * 0.03,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment.png',
                                            height: Get.width * 0.1,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Text(
                                            'Balance',
                                            style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: Get.width * 0.07,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    StreamBuilder(
                                        stream: firestore
                                            .collection('users')
                                            .doc(auth.currentUser!.uid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                              left: Get.width * 0.03,
                                            ),
                                            child: Text(
                                              !snapshot.hasData
                                                  ? 'Rs.0'
                                                  : 'Rs.${snapshot.data!['balance']}',
                                              style: TextStyle(
                                                color: AppColors.blue,
                                                fontSize: Get.width * 0.1,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.25,
                                  width: Get.width * 0.4,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: Get.height * 0.045,
                                        left: Get.width * 0.042,
                                        child: Container(
                                          height: Get.height * 0.16,
                                          width: Get.width * 0.32,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                                Get.width),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 1.4,
                                                spreadRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      FutureBuilder(
                                          future: buildChart(),
                                          builder: (context, snapshot) {
                                            print("jk ${snapshot.data}");
                                            return SfCircularChart(
                                              series: <PieSeries>[
                                                PieSeries<ChartData, dynamic>(
                                                  radius: '93%',
                                                  dataSource: [
                                                    ChartData(
                                                        xData: 'Used',
                                                        yData: spentRatio),
                                                    ChartData(
                                                        xData: 'Remaining',
                                                        yData:
                                                            100 - spentRatio),
                                                  ],
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.xData,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.yData,
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04,
              vertical: Get.height * 0.01,
            ),
            child: Text(
              'Recent Transaction',
              style: TextStyle(
                fontSize: Get.width * 0.075,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
            ),
          ),
          StreamBuilder(
              stream: firestore
                  .collection('Transactions')
                  .doc(auth.currentUser!.uid)
                  .collection('CategoriesTransactions')
                  .orderBy('addTransactionDate', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
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
      ),
    ));
  }
}
