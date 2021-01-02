import 'dart:collection';
import 'dart:math';

import 'package:financial_planner/common/charts/vector_2d.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MappedLineChart extends StatefulWidget {
  const MappedLineChart({Key key, this.chartData}) : super(key: key);

  final List<Vector2D<double>> chartData;

  @override
  State<StatefulWidget> createState() {
    return MappedLineChartState();
  }
}

class MappedLineChartState extends State<MappedLineChart> {
  double minX, minY, maxX, maxY;
  List<FlSpot> data;
  @override
  Widget build(BuildContext context) {
    calculateMaximums();
    data = List.of(widget.chartData.map<FlSpot>((x) => vectorToSpot(x)));
    return Card(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                borderData: FlBorderData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 14,
                      margin: 20,
                      getTextStyles: (x) => const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
                        return title;
                      }),
                ),
                lineBarsData: [
                  new LineChartBarData(spots: data),
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
    widget.chartData.forEach((val) => {
          if (minX == null || val.x < minX) {minX = val.x},
          if (minY == null || val.y < minY) {minY = val.y},
          if (maxX == null || val.x > maxX) {maxX = val.x},
          if (maxY == null || val.y > maxY) {maxY = val.y}
        });
  }
}
