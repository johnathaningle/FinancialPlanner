import 'package:financial_planner/common/data/enums.dart';

class Expense {
  String name;
  Necessity necessity;
  double amount;
  double annualIncreasePercentage; // does the rent increase?
  DateTime beginDate;
  DateTime endDate;
}
