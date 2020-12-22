import 'package:flutter/material.dart';
import 'package:practicinguitwo/practiceObjectItem.dart';

import 'data.dart';

class PracticeUITwo extends StatefulWidget{
  final List<PracticeData> data;
  final ValueChanged<String> updateMyData;
  PracticeUITwo({this.data,this.updateMyData});
  @override State<StatefulWidget> createState() => _PracticeUITwo();
}

class _PracticeUITwo extends State<PracticeUITwo>{
  Color _bgColor(String type){
    Color returnValue = Colors.white;
    switch(type){
      case 'listening':{ returnValue = Colors.purple; break;}
      case 'reading':{ returnValue = Colors.indigo; break;}
      case 'speaking':{ returnValue = Colors.green[200]; break;}
      case 'writing':{ returnValue = Colors.brown[400]; break;}
    }
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:8.0,left:4.0,right:4.0),
        child: Column(
          children: [
            Container(
              width:size.width,
              height: size.height/4 - size.height * (size.height > 800 ? 0.073: 0.065),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                    child: Container(
                      width:120,
                      height: size.height/4 - 30,
                      decoration: BoxDecoration(
                        color: _bgColor(widget.data[0].type.toLowerCase()),
                        borderRadius: BorderRadius.all(
                            Radius.circular(6.0)
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top:size.height * 0.03,//size.height > 800 ? size.height * 0.03 :16,//20:16,
                            left:10,
                            child: Center(
                              child: Container(
                                width: size.height * 0.09,//size.height > 800 ? 76:70,
                                height: size.height * 0.09,//size.height > 800 ? 76:70,
                                child: Image(image:AssetImage(widget.data[0].iconName),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(widget.data[0].type,
                                  style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,shadows: addStrokeToText()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top:size.height > 800 ? size.height * 0.01 : 0,
                    right:12,
                    child: Container(
                      height: 120,
                      width: size.width-130,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: widget.data.map((data) => PracticeObjectItem(dialogImage: widget.data[0].dialogImage,jsonData: data,updateMyData: widget.updateMyData,)).toList()
                      ),
                    ),
                  ),
                ],
              )
            ),
            widget.data[0].type == 'Writing' ? Container() :
            Divider(height: 1,color: Colors.black,thickness: 0.6,endIndent: 12.0,indent: 8.0,),
          ],
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