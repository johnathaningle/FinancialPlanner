import 'package:financial_planner/common/charts/double_bar_chart_value.dart';
import 'package:financial_planner/common/data/asset.dart';
import 'package:financial_planner/common/data/enums.dart';
import 'package:financial_planner/common/data/person.dart';
import 'package:financial_planner/common/services/formulas.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class PlannerService {
  //init the values with sample data
  //https://engaging-data.com/will-money-last-retire-early/
  PlannerService(Person person) {
    this.person = person;
    this.retirementAge = 60;
    this.retirementYears = 30;
    this.yearlySpending = 40000;
    this.savings = 1000000;
    this.mortality = Mortality.Average;
    this.gender = GenderType.Unknown;
    this.spendingFlex = 0.0;
    this.flexThreshold = 0.0;
    this.stock = 0.8;
    this.bond = 0.18;
    this.cash = 0.02;
    this.taxRate = 0.0;
    this.investmentFees = 0.003;
    this.extraExpense = 0;
    this.extraIncome = 0;
    this.extraIncomeStartAge = 50;
    this.extraIncomeEndAge = 70;
    this.extraExpenseStartAge = 50;
    this.extraExpenseEndAge = 70;
    this.accountForInflation = true;
    this.salary = 100583;
    this.percentYearlyRaise = 0.02;
    this.assets = new List<Asset>();
  }

  // number format for money
  final money = new NumberFormat("#,##0.00", "en_US");

  // the person data
  Person person;

  //earnings and savings
  double salary, savings, yearlySpending;

  //retirement age
  int retirementAge, retirementYears;

  //investment types
  double stock, bond, cash;

  //misc spending threshold information
  double spendingFlex, flexThreshold;

  //misc things to factor in for paycheck
  double percentYearlyRaise;

  //tax/fees
  double taxRate, investmentFees;

  //alternative income
  int extraIncome, extraIncomeStartAge, extraIncomeEndAge;

  //alternative expenses
  int extraExpense, extraExpenseStartAge, extraExpenseEndAge;

  //gender info - used for life expectancy range projection
  GenderType gender;

  //todo - use mortality to project ranges for life expectancy to
  // project retirement fund longevity
  Mortality mortality;

  //adjust calculation for inflation
  bool accountForInflation;

  //a list of assets for the user
  List<Asset> assets;

  //Calculate the income based on the yearly raise
  double getIncome(int year) {
    return Formulas.compoundInterest(
        this.salary, year, 1, this.percentYearlyRaise);
  }

  //for each year starting from the current year,
  //calculate the total amount of liabilities for this user
  double getLiabilities(int year) {
    var liabilies = new List<double>();
  }

  double getNetWorth(int year) {
    var worth = this.savings;
    if (assets.length > 0) {
      assets.forEach((x) =>
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
