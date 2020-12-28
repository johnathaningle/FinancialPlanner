import 'package:data_tables/data_tables.dart';
import 'package:financial_planner/common/projection.dart';
import 'package:flutter/material.dart';

class ProjectionScreen extends StatefulWidget {
  @override
  _ProjectionScreenState createState() => _ProjectionScreenState();
}

class _ProjectionScreenState extends State<ProjectionScreen> {
  List<Projection> _items;

  int _rowsOffset;

  int _rowsPerPage;

  _ProjectionScreenState() {
    this._items = new List<Projection>();
    this._rowsOffset = 0;
    this._rowsPerPage = 10;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Plan'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Text(
          "Projections:",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
