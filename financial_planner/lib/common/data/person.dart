import 'package:financial_planner/common/data/enums.dart';

class Person {
  int salary;

  double retirementContribution;

  int startAge;

  int retirementAge;

  int retirementYears;

  int yearlySpending;

  int savings;

  Mortality mortality;

  GenderType gender;

  double spendingFlex;

  double flexThreshold;

  double stock;

  double bond;

  double cash;

  double investmentFees;

  double taxRate;

  int extraExpense;

  int extraIncomeStartAge;

  int extraIncome;

  int extraIncomeEndAge;

  int extraExpenseStartAge;

  bool accountForInflation;

  int extraExpenseEndAge;

  double percentYearlyRaise;

  String name;

  int initalRetirementBalance;

  Person() {
    this.name = "Jon Doe";
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
  }
}
