import 'package:financial_planner/common/charts/double_bar_chart_value.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DoubleBarChart extends StatefulWidget {
  const DoubleBarChart({
    Key key,
    this.title,
    this.subTitle,
    this.barData,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final List<BarChartGroupData> barData;
  @override
  State<StatefulWidget> createState() => DoubleBarChartState();
}

class DoubleBarChartState extends State<DoubleBarChart> {
  Color leftBarColor = Colors.yellowAccent;
  Color rightBarColor = Colors.lightBlue;
  double width = 7;

  List<BarChartGroupData> barGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    //todo - make the below code work (for some reason the y axis doesn't scale properly)
    // barGroups = widget.barData;
    final barGroup1 = DoubleBarChartValue.makeGroupData(width, 0, 5, 12);
    final barGroup2 = DoubleBarChartValue.makeGroupData(width, 1, 16, 12);
    final barGroup3 = DoubleBarChartValue.makeGroupData(width, 2, 18, 5);
    final barGroup4 = DoubleBarChartValue.makeGroupData(width, 3, 20, 16);
    final barGroup5 = DoubleBarChartValue.makeGroupData(width, 4, 17, 6);
    final barGroup6 = DoubleBarChartValue.makeGroupData(width, 5, 19, 1.5);
    final barGroup7 = DoubleBarChartValue.makeGroupData(width, 6, 10, 1.5);

    barGroups = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.bar_chart,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.subTitle,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 25,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (_a, _b, _c, _d) => null,
                          ),
                          touchCallback: (response) {
                            if (response.spot == null) {
                              setState(() {
                                touchedGroupIndex = -1;
                                barGroups = List.of(widget.barData);
                              });
                              return;
                            }

                            touchedGroupIndex =
                                response.spot.touchedBarGroupIndex;

                            setState(() {
                              if (response.touchInput is FlLongPressEnd ||
                                  response.touchInput is FlPanEnd) {
                                touchedGroupIndex = -1;
                                barGroups = List.of(widget.barData);
                              } else {
                                barGroups = List.of(widget.barData);
                                if (touchedGroupIndex != -1) {
                                  double sum = 0;
                                  for (BarChartRodData rod
                                      in barGroups[touchedGroupIndex].barRods) {
                                    sum += rod.y;
                                  }
                                  final avg = sum /
                                      barGroups[touchedGroupIndex]
                                          .barRods
                                          .length;

                                  barGroups[touchedGroupIndex] =
                                      barGroups[touchedGroupIndex].copyWith(
                                    barRods: barGroups[touchedGroupIndex]
                                        .barRods
                                        .map((rod) {
                                      return rod.copyWith(y: avg);
                                    }).toList(),
                                  );
                                }
                              }
                            });
                          }),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) {
                            return value.toInt().toString();
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 32,
                          reservedSize: 14,
                          getTitles: (value) {
                            if (value == 0) {
                              return '1K';
                            } else if (value == 10) {
                              return '5K';
                            } else if (value == 19) {
                              return '10K';
                            } else {
                              return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: barGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
