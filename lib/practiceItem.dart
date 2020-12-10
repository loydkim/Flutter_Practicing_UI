import 'package:flutter/material.dart';
import 'package:practicinguitwo/main.dart';
import 'package:practicinguitwo/practiceContentItem.dart';

class PracticeItem extends StatefulWidget{
  final PracticeItemStructure data;
  PracticeItem({this.data});
  @override State<StatefulWidget> createState() => _PracticeItem();
}

List<PracticeItemStructure> practiceContentData = [
  new PracticeItemStructure(imageName: 'images/listening.jpg',title: 'Item1',subTitle: 'Improve listening',date:'2020-12-08',subject: 'Example'),
  new PracticeItemStructure(imageName: 'images/reading.jpg',title: 'Item2',subTitle: 'Reading article',date:'2020-12-08',subject: 'Travel'),
  new PracticeItemStructure(imageName: 'images/speaking.jpg',title: 'Item3',subTitle: 'Practicing pronunciation',date:'2020-12-08',subject: 'Sport'),
  new PracticeItemStructure(imageName: 'images/writing.jpg',title: 'Item4',subTitle: 'Learn Writing form',date:'2020-12-08',subject: 'History'),
  new PracticeItemStructure(imageName: 'images/listening.jpg',title: 'Item5',subTitle: 'Improve listening',date:'2020-12-08',subject: 'Animal'),
  new PracticeItemStructure(imageName: 'images/reading.jpg',title: 'Item6',subTitle: 'Reading article',date:'2020-12-08',subject: 'Game'),
  new PracticeItemStructure(imageName: 'images/speaking.jpg',title: 'Item7',subTitle: 'Practicing pronunciation',date:'2020-12-08',subject: 'School'),
  new PracticeItemStructure(imageName: 'images/writing.jpg',title: 'Item8',subTitle: 'Learn Writing form',date:'2020-12-08',subject: 'Business'),
];

class _PracticeItem extends State<PracticeItem>{

  PageController _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.2
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:8.0,left:4.0,right:4.0),
        child: Container(
          width:size.width,
          height: size.height/4 - 30,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                child: Container(
                  width:120,
                  height: size.height/4 - 30,
                  decoration: BoxDecoration(
                    color: widget.data.bgColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(6.0)
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top:16,
                        left:10,
                        child: Center(
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Image(image:AssetImage(widget.data.imageName),
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
                            child: Text(widget.data.title,
                              style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold,shadows: addStrokeToText()),
                            ),
                          ),
                          // Text(widget.data.subTitle,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,shadows: addStrokeToText()),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right:12,
                top:7,
                child: Container(
                  // decoration: BoxDecoration(color:Colors.white),
                  height: 120,
                  width: size.width-130,
                  child:
                  // PageView(
                  //   controller: _controller,
                  //   children: practiceContentData.map((data) => PracticeContentItem(data:data)).toList()
                  // ),
                  ListView(
                      scrollDirection: Axis.horizontal,
                      children: practiceContentData.map((data) => PracticeContentItem(data:data)).toList()
                  ),
                ),
              )
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