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

  //gender info
  GenderType gender;

  //todo - What does this do again?
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
  }

  List<String> Summary() {
    var summary = new List<String>();
    summary.add("Based on your planning data...");
    var incomeData = getIncome(28);
    incomeData.forEach((element) {
      summary.add(element.toString());
    });
    return summary;
  }
}
