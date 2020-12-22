import 'package:flutter/material.dart';

import 'data.dart';
import 'practiceObjectItem.dart';

class PracticeUIOne extends StatefulWidget{
  final List<PracticeData> data;
  final ValueChanged<String> updateMyData;
  PracticeUIOne({this.data,this.updateMyData});
  @override State<StatefulWidget> createState() => _PracticeUIOne();
}

class _PracticeUIOne extends State<PracticeUIOne>{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:8.0,left:4.0,right:4.0),
      child: Container(
          width:size.width,
          height: size.height/4 - size.height * (size.height > 800 ? 0.07: 0.062),//size.height > 800 ? size.height/4 - size.height * 0.07 : size.height/4 - 46,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image:AssetImage(widget.data[0].dialogImage),
                fit: BoxFit.cover),
            border: Border.all(color: Colors.grey[400]),
            borderRadius: BorderRadius.all(
                Radius.circular(22.0)
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(widget.data[0].type,
                      style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold,shadows: addStrokeToText()),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.height > 800 ? size.height * 0.01 : 0,
                right:12,
                child: Container(
                  height: 120,
                  width: size.width-150,
                  child:
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: widget.data.map((data) => PracticeObjectItem(dialogImage: widget.data[0].dialogImage,jsonData: data,updateMyData: widget.updateMyData,)).toList()
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  static List<Shadow> addStrokeToText(){
    Color shadowColor = Colors.black;
    return [
      Shadow( // bottomLeft
          offset: Offset(-1.5, -1.5),
          color: shadowColor
      ),
      Shadow( // bottomRight
          offset: Offset(1.5, -1.5),
          color: shadowColor
      ),
      Shadow( // topRight
          offset: Offset(1.5, 1.5),
          color: shadowColor
      ),
      Shadow( // topLeft
          offset: Offset(-1.5, 1.5),
          color: shadowColor
      ),
    ];
  }
}