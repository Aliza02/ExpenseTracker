import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/bloc/onboardingBloc/statsBloc/stats_bloc.dart';
import 'package:expensetracker/bloc/onboardingBloc/statsBloc/stats_events.dart';
import 'package:expensetracker/bloc/onboardingBloc/statsBloc/stats_states.dart';
import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/model/chart_data.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/res/icons.dart';
import 'package:expensetracker/widgets/appBar.dart';
import 'package:expensetracker/widgets/category_card.dart';
import 'package:expensetracker/widgets/heading.dart';
import 'package:expensetracker/widgets/text.dart';
import 'package:expensetracker/widgets/transaction_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class data {
  int a;
  int b;
  data(this.a, this.b);
}

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    int lengthOfLabelsList =
        0; // length of row which is building labels of xaxis of bar chart. It will change based on weekly and monthly stats selection

    Map<int, int> weekDaysAmount = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
    };

    Map<String, int> weeklyDonutChartData = {};

    List<data> weeklyBarData = [
      data(1, 1),
      data(2, 1),
      data(3, 1),
      data(4, 1),
      data(5, 1),
      data(6, 1),
      data(7, 1),
    ];
    List<ChartData> Weeklydata = [
      ChartData(xData: 'Entertainment', yData: 20),
      ChartData(xData: 'Bill', yData: 10),
      ChartData(xData: 'Education', yData: 40),
      ChartData(xData: 'Grocery', yData: 20),
      ChartData(xData: 'Transport', yData: 10),
    ];

    Future<void> getWeeklyChartData() async {
      await firestore
          .collection('Transactions')
          .doc(auth.currentUser!.uid)
          .collection('CategoriesTransactions')
          .orderBy('addTransactionDate', descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          int amount = element['amount'];

          DateTime date = DateTime.fromMillisecondsSinceEpoch(
              element['addTransactionDate'].millisecondsSinceEpoch);

          weekDaysAmount.update(date.weekday, (value) => value + amount);
          print(weekDaysAmount);

          weeklyDonutChartData.addAll({element['category']: amount});
          weeklyDonutChartData.update(
              element['category'], (value) => value + amount);
        });
      });

      weeklyBarData.clear();
      Weeklydata.clear();

      weekDaysAmount.forEach((key, value) {
        if (value == 0) {
          weeklyBarData.add(data(key, value + 1));
        } else {
          weeklyBarData.add(data(key, value));
        }
      });

      weeklyDonutChartData.forEach((key, value) {
        Weeklydata.add(ChartData(xData: key, yData: value.toDouble()));
      });

      print(weeklyBarData.length);
      print(Weeklydata.length);
    }

    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    List<String> weekDays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    List<data> monthylBarData = [
      data(1, 20000),
      data(2, 50000),
      data(3, 10000),
      data(4, 35000),
      data(5, 40000),
      data(6, 35000),
      data(7, 23000),
      data(8, 34000),
      data(9, 25000),
      data(10, 79000),
      data(11, 66000),
      data(12, 56000),
    ];

    List<ChartData> Monthlydata = [
      ChartData(xData: 'Entertainment', yData: 40),
      ChartData(xData: 'Travel', yData: 20),
      ChartData(xData: 'Education', yData: 20),
      ChartData(xData: 'Grocery', yData: 10),
      ChartData(xData: 'Transport', yData: 10),
    ];

    List<Color> colors = [
      Color(0xFFFc06c84),
      Color(0xFFF4b87b9),
      Color(0xFFFf67280),
      Color(0xFFFf8b195),
      Color(0xFFF74b49b),
    ];

    List<String> buttonName = ['Weekly', 'Monthly'];

    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.cream,
      appBar: const appBar(),
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const heading(title: 'Stats'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.02,
                    ),
                    width: Get.width * 0.47,
                    child: BlocBuilder<statsBloc, StatsStates>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor:
                                (state is StatButtonSelectedStates &&
                                        state.index == index)
                                    ? AppColors.blue
                                    : AppColors.cream,
                            shape: BeveledRectangleBorder(
                              side: BorderSide(
                                color: AppColors.blue.withOpacity(0.3),
                                width: 1.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (index == 0) {
                              // getWeeklyChartData();
                              BlocProvider.of<statsBloc>(context)
                                  .add(WeeklyStatsEvents());
                            } else {
                              BlocProvider.of<statsBloc>(context)
                                  .add(MonthlyStatsEvents());
                            }
                          },
                          child: text(
                              title: buttonName[index],
                              fontSize: Get.width * 0.04,
                              fontWeight: FontWeight.w400,
                              color: (state is StatButtonSelectedStates &&
                                      state.index == index)
                                  ? AppColors.cream
                                  : AppColors.blue),
                        );
                      },
                    ),
                  ),
                ),
              ),
              BlocBuilder<statsBloc, StatsStates>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      Positioned(
                        top: Get.height * 0.098,
                        left: Get.width * 0.08,
                        child: Container(
                          height: Get.height * 0.215,
                          width: Get.width * 0.43,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(Get.width),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SfCircularChart(
                        // margin: EdgeInsets.only(bottom: 100.0),
                        
                        legend: const Legend(
                          
                          textStyle: TextStyle(
                            color: AppColors.blue,
                            fontSize: 16.0,
                            
                          ),
                        
                          isVisible: true,
                          isResponsive: true,
                          orientation: LegendItemOrientation.vertical,
                          shouldAlwaysShowScrollbar: false,

                          // overflowMode: LegendItemOverflowMode.wrap,
                          alignment: ChartAlignment.near,
                          position: LegendPosition.right,
                        ),
                        series: [
                          PieSeries<ChartData, dynamic>(
                            radius: '80%',
                            dataSource: (state is StatButtonSelectedStates &&
                                    state.index == 0)
                                ? Weeklydata
                                : Monthlydata,
                            xValueMapper: (ChartData data, _) => data.xData,
                            yValueMapper: (ChartData data, _) => data.yData,
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<statsBloc, StatsStates>(
                builder: (context, state) {
                  return SizedBox(
                    height: Get.height * 0.32,
                    child: FutureBuilder(
                        future: (state is StatButtonSelectedStates &&
                                state.index == 0)
                            ? getWeeklyChartData()
                            : null,
                        builder: (context, snapshot) {
                          return SfCartesianChart(
                            plotAreaBorderWidth: 0.0,
                            isTransposed: true,
                            primaryYAxis: const CategoryAxis(
                              isVisible: false,
                            ),
                            primaryXAxis: const CategoryAxis(
                              interval: 1,
                              isVisible: false,
                            ),
                            series: <CartesianSeries>[
                              (state is StatButtonSelectedStates &&
                                      state.index == 0)
                                  ? BarSeries<data, dynamic>(
                                      color: colors[0],
                                      // spacing: 0.2,
                                      width: 0.2,
                                      isTrackVisible: true,

                                      trackColor:
                                          AppColors.grey.withOpacity(0.3),
                                      dataSource: weeklyBarData,
                                      borderRadius: BorderRadius.circular(10.0),
                                      xValueMapper: (data data, _) => data.a,
                                      yValueMapper: (data data, _) => data.b,
                                    )
                                  : BarSeries<data, dynamic>(
                                      color: colors[0],
                                      // spacing: 0.2,
                                      width: 0.2,
                                      isTrackVisible: true,
                                      trackColor:
                                          AppColors.grey.withOpacity(0.3),
                                      dataSource: monthylBarData,
                                      borderRadius: BorderRadius.circular(10.0),
                                      xValueMapper: (data data, _) => data.a,
                                      yValueMapper: (data data, _) => data.b,
                                    )
                            ],
                          );
                        }),
                  );
                },
              ),
              BlocBuilder<statsBloc, StatsStates>(
                builder: (context, state) {
                  if (state is StatButtonSelectedStates && state.index == 0) {
                    lengthOfLabelsList = 7;
                  } else {
                    lengthOfLabelsList = 12;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      lengthOfLabelsList,
                      (index) => Container(
                        margin: EdgeInsets.only(
                          left: Get.width * 0.013,
                        ),
                        child: text(
                          title: (state is StatButtonSelectedStates &&
                                  state.index == 0)
                              ? weekDays[index]
                              : months[index],
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
