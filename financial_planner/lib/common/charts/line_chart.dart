import 'dart:collection';
import 'dart:math';

import 'package:financial_planner/common/charts/vector_2d.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MappedLineChart extends StatelessWidget {
  MappedLineChart({Key key, this.chartData}) : super(key: key);

  final List<Vector2D<double>> chartData;
  double minX, minY, maxX, maxY;

  @override
  Widget build(BuildContext context) {
    var titles = new HashSet<String>();
    calculateMaximums();
    var spots = List.of(chartData.map<FlSpot>((x) => vectorToSpot(x)));
    return Card(
      color: Colors.black87,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LineChart(
              LineChartData(
                minX: minX,
                minY: minY,
                maxX: maxX,
                maxY: maxY,
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (double x) => TextStyle(
                            color: Colors.white,
                          ),
                      getTitles: (double x) {
                        var title = "";
                        var val = (x / 1000).floor();
                        if (val < 1000) {
                          title = val.toString() + "K";
                        }
                        if (val >= 1000) {
                          val = (x / 10000).floor();
                          if (val < 1000) {
                            title = val.toString() + "M";
                          } else {
                            title = "";
                          }
                        }
                        if (titles.contains(title)) {
                          return "";
                        } else {
                          titles.add(title);
                        }
                        return title;
                      }),
                ),
                gridData: FlGridData(
                  show: true,
                ),
                lineBarsData: [
                  new LineChartBarData(spots: spots),
                ],
                backgroundColor: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlSpot vectorToSpot(Vector2D<double> source) {
    return new FlSpot(source.x, source.y);
  }

  void calculateMaximums() {
    minX = null;
    minY = null;
    maxX = null;
    maxY = null;
    chartData.forEach((val) => {
          if (minX == null || val.x < minX) {minX = val.x},
          if (minY == null || val.y < minY) {minY = val.y},
          if (maxX == null || val.x > maxX) {maxX = val.x},
          if (maxY == null || val.y > maxY) {maxY = val.y}
        });
  }
}
