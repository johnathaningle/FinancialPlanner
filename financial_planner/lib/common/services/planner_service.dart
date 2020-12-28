import 'package:financial_planner/common/person.dart';
import 'package:financial_planner/common/projection.dart';

class PlannerService {
  Person person;

  /**
   * Calculate the income based on the yearly raise
   */
  List<int> getIncome(int numYears) {
    var currentValue = this.person.salary;
    var values = new List<int>();
    for (int i = 0; i < numYears; i++) {
      values.add(currentValue);
      currentValue =
          (currentValue + (currentValue * (this.person.percentYearlyRaise)))
              .toInt();
    }
    return values;
  }

  List<Projection> getProjections() {
    var projections = new List<Projection>();
  }

  //init the values with sample data
  //https://engaging-data.com/will-money-last-retire-early/
  PlannerService(Person person) {
    this.person = person;
  }

  List<String> summary() {
    var summary = new List<String>();
    summary.add("Based on your planning data...");
    var incomeData = getIncome(28);
    incomeData.forEach((element) {
      summary.add(element.toString());
    });
    return summary;
  }

  static int getRetirementContribution(
      int salary, double retirementContribution) {
    return (salary * retirementContribution).toInt();
  }
}
