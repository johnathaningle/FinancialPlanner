import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DoubleBarChartValue {
  static BarChartGroupData makeGroupData(
      double width, int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [Colors.lightBlue],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [Colors.orangeAccent],
        width: width,
      ),
    ]);
  }

  static String getYAxisLabels(double value) {
    if (value < 10000) {
      return "<10k";
    }
    if (value / 1000000 < 10) {
      return (value / 10000).toInt().toString() + "K";
    }

    return value.toString();
  }
}
