import 'package:flutter/material.dart';

import 'main.dart';
import 'practiceOneItem.dart';

class PracticeOne extends StatefulWidget{
  final PracticeItemStructure data;
  PracticeOne({this.data});
  @override State<StatefulWidget> createState() => _PracticeOne();
}

class _PracticeOne extends State<PracticeOne> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: practicingOneData.map((data) => PracticeOneItem(data:data)).toList()
      ),
    );
  }
}