import 'package:financial_planner/common/data/asset.dart';
import 'package:financial_planner/common/data/enums.dart';
import 'package:financial_planner/common/data/expense.dart';

class Person {
  int currentAge;

  double salary;

  double retirementContribution;

  int startAge;

  int retirementAge;

  double retirementYears;

  double yearlySpending;

  double savings;

  Mortality mortality;

  GenderType gender;

  double spendingFlex;

  double flexThreshold;

  double stock;

  double bond;

  double cash;

  double investmentFees;

  double taxRate;

  double extraExpense;

  int extraIncomeStartAge;

  double extraIncome;

  int extraIncomeEndAge;

  int extraExpenseStartAge;

  bool accountForInflation;

  int extraExpenseEndAge;

  double percentYearlyRaise;

  String name;

  int initalRetirementBalance;

  int expectedDeathAge;

  //a list of assets for the user
  List<Asset> assets;

  //a list of expenses for the user
  List<Expense> expenses;

  Person() {
    this.name = "Jon Doe";
    this.currentAge = 30;
    this.retirementAge = 40;
    this.retirementYears = 50;
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
    this.initalRetirementBalance = 206893;
    this.expectedDeathAge = 95;
    var expenses = new List<Expense>();
    var e = new Expense();
    e.name = "Rent";
    e.amount = 1000;
    e.annualIncreasePercentage = 0.02;
    e.necessity = Necessity.Critical;
    expenses.add(e);
    var e2 = new Expense();
    e2.name = "Dining Out";
    e2.amount = 50.00 * 52;
    e2.necessity = Necessity.Expendable;
    expenses.add(e2);
    this.expenses = expenses;
    this.assets = new List<Asset>();
  }

  int expectedLifeRemaining() {
    return expectedDeathAge - currentAge;
  }
}
