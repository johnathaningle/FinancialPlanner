import 'package:data_tables/data_tables.dart';
import 'package:financial_planner/common/buttons/floating_action_button.dart';
import 'package:financial_planner/common/charts/double_bar_chart.dart';
import 'package:financial_planner/common/charts/chart_constants.dart';
import 'package:financial_planner/common/charts/line_chart.dart';
import 'package:financial_planner/common/data/person.dart';
import 'package:financial_planner/common/services/formulas.dart';
import 'package:financial_planner/common/services/planner_service.dart';
import 'package:flutter/material.dart';

class ProjectionScreen extends StatefulWidget {
  const ProjectionScreen({Key key}) : super(key: key);

  @override
  _ProjectionScreenState createState() => _ProjectionScreenState();
}

class _ProjectionScreenState extends State<ProjectionScreen> {
  int _rowsOffset;

  int _rowsPerPage;

  PlannerService plannerService;

  _ProjectionScreenState() {
    this._rowsOffset = 0;
    this._rowsPerPage = 10;
    super.initState();
    plannerService = new PlannerService(new Person());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Plan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoubleBarChart(
              title: "Projections",
              subTitle: "Net Worth",
              barData:
                  plannerService.getNetWorthForcast(ChartConstants.width, 10),
            ),
            MappedLineChart(chartData: plannerService.getExpensesOverTime())
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
