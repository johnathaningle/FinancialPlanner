import 'package:intl/intl.dart';

enum GenderType {
  Male,
  Female,
  Unknown,
}

enum Mortality {
  Poor,
  Average,
  Good,
}

enum Frequency {
  Weekly,
  BiWeekly,
  TwiceMonthly,
  Monthly,
  Annually,
}

// how negotiable is this expense?
// this will be used when making recommendations for budget optimisations
enum Necessity {
  Critical, // this expense cannot be removed and is difficult to reduce
  Adjustable, // this needs to stick around but there's some wiggle room on cost
  Expendable, // worst case scenario, I can drop this expense
}

// a contribution to an account based on an income
class IncomeAccountContribution {
  int id;
  int incomeId;
  int accountId;
  String name; // "401k match", "401k contribution", etc
  double incomePercent;
  double annualIncrease;
  double maxPercent;
  Frequency frequency; // (nullable) null unless different from income frequency
}

// money/stock that (ideally) earns interest (savings, 401k, etc.)
class Account {
  int id;
  String name;
  double balance;
  double apy; // average based on typical performance
}

// recurring, non-terminating payments (HOA, phone, rent, etc.)
// if there's multiple of the same necessity, be lazy and group them
class Expense {
  String name;
  Necessity necessity;
  double amount;
  double annualIncreasePercentage; // does the rent increase?
  DateTime beginDate;
  DateTime endDate;
}

// payments coming in. these are not earnings on savings accounts
class Income {
  int id;
  String name;
  Frequency frequency;
  double amount;
  double annualIncreasePercentage; // annual raise? charged rent increase?
  DateTime beginDate; // is this a delayed start like social security?
  DateTime endDate; // planning to quit, scale back, sell rental?
}

// something with significant value for calculating worth (car, house)
class Asset {
  String name;
  double value;
  double appreciation; // +% if value increases, -% if value decreases
}

// money owed that has a balance that can be paid off and terminated
class Debt {
  String name;
  double principal;
  double annualInterest;
  double minumumMonthlyPayment;
  double additionalMonthlyPayment; // (nullable)
  double escrow; // (nullable)
}

class Liability {
  int amount;
  String name;
}

class Person {
  int salary;
  double retirementContribution;
}

class PlannerService {
  //earnings and savings
  int salary, savings, yearlySpending;

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

  /**
   * Calculate the income based on the yearly raise
   */
  List<int> getIncome(int numYears) {
    var currentValue = this.salary;
    var values = new List<int>();
    for (int i = 0; i < numYears; i++) {
      values.add(currentValue);
      currentValue =
          (currentValue + (currentValue * (this.percentYearlyRaise))).toInt();
    }
    return values;
  }

  //init the values with sample data
  //https://engaging-data.com/will-money-last-retire-early/
  PlannerService() {
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
  }

  // number format for money
  final money = new NumberFormat("#,##0.00", "en_US");

  List<String> Summary() {
    var summary = new List<String>();
    summary.add("Based on your planning data...");

    // do income projection
    var incomeData = getIncome(10);
    int c = 1;
    incomeData.forEach((element) {
      summary.add("Year " + c.toString() + ": \$" + money.format(element));
      c++;
    });

    // do debt projection

    return summary;
  }
}
