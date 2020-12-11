import 'package:flutter/material.dart';

import 'main.dart';
import 'practiceTwoItem.dart';

class PracticeTwo extends StatefulWidget{
  final PracticeItemStructure data;
  PracticeTwo({this.data});
  @override State<StatefulWidget> createState() => _PracticeTwo();
}

class _PracticeTwo extends State<PracticeTwo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: practicingTwoData.map((data) => PracticeTwoItem(data:data)).toList()
      ),
    );
  }
}