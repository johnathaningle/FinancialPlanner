import 'package:flutter/material.dart';

var floatingActionButton = FloatingActionButton(
  child: Text(
    "?",
    style: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  onPressed: floatingActionButtonFunction,
);

var floatingActionButtonFunction = () {
  print("help");
};
