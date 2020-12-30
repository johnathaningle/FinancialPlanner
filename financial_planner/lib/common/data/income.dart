// payments coming in. these are not earnings on savings accounts
import 'enums.dart';

class Income {
  int id;
  String name;
  Frequency frequency;
  double amount;
  double annualIncreasePercentage; // annual raise? charged rent increase?
  DateTime beginDate; // is this a delayed start like social security?
  DateTime endDate; // planning to quit, scale back, sell rental?
}
