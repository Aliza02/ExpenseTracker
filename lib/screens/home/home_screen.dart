import 'package:expensetracker/model/chart_data.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/res/icons.dart';
import 'package:expensetracker/res/images.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<ChartData> data = [
      ChartData(xData: 'Remaining', yData: 100),
      ChartData(xData: 'Used', yData: 30),
    ];
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: AppColors.cream,
        elevation: 6.0,
        notchMargin: 6.0,
        height: 50.0,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.18,
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  AppIcons.home,
                  height: Get.width * 0.06,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.2,
              child: InkWell(
                onTap: () {},
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
                onTap: () {},
                child: Image.asset(
                  AppIcons.stats,
                  height: Get.width * 0.06,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.18,
              child: InkWell(
                onTap: () {},
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
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: Get.width * 0.065,
                            ),
                            child: Text(
                              'Aliza Aziz',
                              style: TextStyle(
                                fontSize: Get.width * 0.065,
                                fontWeight: FontWeight.normal,
                                color: AppColors.cream,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width * 0.9,
                      // height: Get.height * 0.2,
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
                              // top: Get.height * 0.05,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/payment.png',
                                          height: Get.width * 0.1,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Text(
                                          'Balance',
                                          style: TextStyle(
                                            color: AppColors.blue,
                                            fontSize: Get.width * 0.07,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: Get.width * 0.03,
                                      ),
                                      child: Text(
                                        'Rs.90000',
                                        style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: Get.width * 0.1,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.25,
                                  width: Get.width * 0.4,
                                  child: SfCircularChart(
                                    series: <PieSeries>[
                                      PieSeries<ChartData, dynamic>(
                                        dataSource: data,
                                        xValueMapper: (ChartData data, _) =>
                                            data.xData,
                                        yValueMapper: (ChartData data, _) =>
                                            data.yData,
                                      )
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
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04,
                    vertical: Get.height * 0.01,
                  ),
                  child: Container(
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.6, 1),
                          color: Colors.grey.withOpacity(0.5),
                          // blurStyle: BlurStyle.solid,
                          blurRadius: 1.8,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.food_bank_outlined),
                        Text('ads'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
