//money owed that has a balance that can be paid off and terminated
class Debt {
  String name;
  double principal;
  double annualInterest;
  double minumumMonthlyPayment;
  double additionalMonthlyPayment; // (nullable)
  double escrow; // (nullable)
}
