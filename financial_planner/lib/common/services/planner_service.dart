import 'package:financial_planner/common/charts/double_bar_chart_value.dart';
import 'package:financial_planner/common/charts/vector_2d.dart';
import 'package:financial_planner/common/data/asset.dart';
import 'package:financial_planner/common/data/enums.dart';
import 'package:financial_planner/common/data/expense.dart';
import 'package:financial_planner/common/data/person.dart';
import 'package:financial_planner/common/services/formulas.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class PlannerService {
  //init the values with sample data
  //https://engaging-data.com/will-money-last-retire-early/
  PlannerService(Person person) {
    this.person = person;
    this.accountForInflation = true;
  }

  // number format for money
  final money = new NumberFormat("#,##0.00", "en_US");

  // the person data
  Person person;

  //adjust calculation for inflation
  bool accountForInflation;

  //Calculate the income based on the yearly raise
  double getIncome(int year) {
    return Formulas.compoundInterest(
        this.person.salary, year, 1, this.person.percentYearlyRaise);
  }

  //for each year starting from the current year,
  //calculate the total amount of liabilities for this user
  // double getLiabilities(int year) {
  //   var liabilies = new List<double>();
  // }

  double getNetWorth(int year) {
    var worth = this.person.savings;
    if (person.assets.length > 0) {
      person.assets.forEach((x) =>
          worth += Formulas.compoundInterest(x.value, year, 1, x.appreciation));
    }
    return worth;
  }

  //todo - somehow remove chartWidth from this function parameter
  List<BarChartGroupData> getNetWorthForcast(double chartWidth, int numYears) {
    var data = new List<BarChartGroupData>();
    for (int i = 0; i < numYears; i++) {
      data.add(DoubleBarChartValue.makeGroupData(
          chartWidth, i, getNetWorth(i), getNetWorth(i)));
    }
    return data;
  }

  List<Vector2D<double>> getExpensesOverTime() {
    var data = new List<Vector2D<double>>();
    for (double year = 0; year < person.expectedLifeRemaining(); year++) {
      var now = DateTime.now();
      var point = new Vector2D<double>();
      point.x = now.year + year;
      var expenses = this
          .person
          .expenses
          .where((x) =>
              (x.beginDate == null || x.beginDate.compareTo(now) <= 0) &&
              (x.endDate == null || x.endDate.compareTo(now) >= 0))
          .toList();
      if (expenses != null && expenses.length > 0) {
        double sum = 0.0;
        expenses.forEach((x) => sum += Formulas.compoundInterest(
            x.amount, year.toInt(), 1, x.annualIncreasePercentage));
        point.y = sum;
      }
      data.add(point);
    }
    return data;
  }

  List<String> summary() {
    var summary = new List<String>();
    summary.add("Based on your planning data...");

    // do income projection
    var incomeData = new List<double>();
    for (var i = 0; i < 10; i++) {
      incomeData.add(getIncome(i));
    }
    int c = 1;
    incomeData.forEach((element) {
      summary.add("Year " + c.toString() + ": \$" + money.format(element));
      c++;
    });

    // do debt projection
    return summary;
  }

  static double getRetirementContribution(
      int salary, double retirementContribution) {
    return salary * retirementContribution;
  }
}
