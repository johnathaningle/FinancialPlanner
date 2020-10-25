import 'package:financial_planner/common/person.dart';
import 'package:financial_planner/common/services/planner_service.dart';

class Projection {
  Person person;

  List<ProjectionData> getProjections(int numYears) {
    var projections = new List<ProjectionData>();

    //create the 0th year projection
    var initialProjection = new ProjectionData();
    initialProjection.age = person.startAge;
    initialProjection.retirementAccountBalance = person.initalRetirementBalance;
    initialProjection.retirementAccountContribution =
        PlannerService.getRetirementContribution(
            person.salary, person.retirementContribution);

    //add the year 0 projection
    projections.add(initialProjection);

    //add the projection for each of the other years
    for (var i = 1; i < numYears; i++) {
      //create the new projection
      var p = new ProjectionData();
      //get the previous projection
      var previousProjection = projections[i - 1];
      //incrment the age
      p.age = previousProjection.age + 1;

      //calculate the salary
      p.salary =
          (previousProjection.salary * (1 + person.percentYearlyRaise)).toInt();

      //calculate the account balance for the retirement account
      p.retirementAccountBalance = previousProjection.retirementAccountBalance +
          previousProjection.retirementAccountContribution;

      //calculate the yearly retirement account contribution
      p.retirementAccountContribution =
          PlannerService.getRetirementContribution(
              p.salary, person.retirementContribution);

      //add the new projection
      projections.add(p);
    }
    return projections;
  }
}

class ProjectionData {
  int age;

  int salary;

  int retirementAccountBalance;

  int retirementAccountContribution;

  //todo - add a net worth calculation
  int netWorth = 0;
}
