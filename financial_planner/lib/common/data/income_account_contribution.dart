// a contribution to an account based on an income
import 'package:financial_planner/common/data/enums.dart';

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
