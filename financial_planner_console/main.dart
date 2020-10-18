import 'planner_service.dart';

void main(List<String> args) {
  var pt = new PlannerService();
  pt.Summary()
    ..forEach((element) {
      print(element);
    });
}
