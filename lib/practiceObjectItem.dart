import 'package:flutter/material.dart';
import 'package:practicinguitwo/showObjectDialog.dart';

import 'data.dart';

class PracticeObjectItem extends StatefulWidget{
  final PracticeData jsonData;
  final String dialogImage;
  final ValueChanged<String> updateMyData;
  PracticeObjectItem({this.dialogImage,this.jsonData,this.updateMyData});
  @override State<StatefulWidget> createState() => _PracticeObjectItem();
}

class _PracticeObjectItem extends State<PracticeObjectItem>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => showObjectDialog(context,widget.jsonData,widget.dialogImage,widget.updateMyData));
      },
      child: Stack(
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
                      // Text(widget.jsonData.subject,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Text(widget.jsonData.simpleExplain,style:TextStyle(fontSize: 16,color: widget.jsonData.isFinished ? Colors.grey[600]: Colors.black )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Row(
                          children: [
                            _countStars(widget.jsonData.stars, 1),
                            _countStars(widget.jsonData.stars, 2),
                            _countStars(widget.jsonData.stars, 3),
                            _countStars(widget.jsonData.stars, 4),
                            _countStars(widget.jsonData.stars, 5),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Text(widget.jsonData.releaseDate,style:TextStyle(fontSize: 14,color: Colors.grey[600])),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 134,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.jsonData.subject,style: TextStyle(color:  widget.jsonData.isFinished ? Colors.grey[600]: widget.jsonData.subject == 'Example' ? Colors.green[900] : Colors.indigo[900],fontSize: 22,fontWeight: FontWeight.bold,shadows: addStrokeToText()),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Icon _countStars(int rating, int index) {
    if (index <= rating) {
      return Icon(
        Icons.star,
        color:  widget.jsonData.isFinished ? Colors.amber[300]: Colors.amber,
        size: 16.0,
      );
    } else {
      return Icon(Icons.star_border, color: widget.jsonData.isFinished ? Colors.amber[300]: Colors.amber,size: 16.0);
    }
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