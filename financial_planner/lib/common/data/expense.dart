import 'package:financial_planner/common/data/enums.dart';

class Expense {
  String name;
  Necessity necessity;
  double amount;
  double annualIncreasePercentage = 0.0; // does the rent increase?
  DateTime beginDate;
  DateTime endDate;
}
