import 'package:flutter/material.dart';
import 'package:practicinguitwo/main.dart';

class PracticeContentItem extends StatefulWidget{
  final PracticeItemStructure data;
  PracticeContentItem({this.data});
  @override State<StatefulWidget> createState() => _PracticeContentItem();
}

class _PracticeContentItem extends State<PracticeContentItem>{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left:4.0,right:2.0,top: 10.0),
          child: Card(
            elevation: 4.0,
            child: Container(
              width:120,
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: Text(widget.data.subTitle,style:TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: Text(widget.data.date,style:TextStyle(fontSize: 14,color: Colors.grey[600])),
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.data.subject,style: TextStyle(color: Colors.indigo[900],fontSize: 22,fontWeight: FontWeight.bold,shadows: addStrokeToText()),),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static List<Shadow> addStrokeToText(){
    Color shadowColor = Colors.white;
    double offSetSize = 1.0;
    return [
      Shadow( // bottomLeft
          offset: Offset(-offSetSize, -offSetSize),
          color: shadowColor
      ),
      Shadow( // bottomRight
          offset: Offset(offSetSize, -offSetSize),
          color: shadowColor
      ),
      Shadow( // topRight
          offset: Offset(offSetSize, offSetSize),
          color: shadowColor
      ),
      Shadow( // topLeft
          offset: Offset(-offSetSize, offSetSize),
          color: shadowColor
      ),
    ];
  }
}