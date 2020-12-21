import 'package:flutter/material.dart';
import 'package:practicinguitwo/startPractice.dart';

import 'data.dart';

Icon _countStars(int rating, int index) {
  if (index <= rating) {
    return Icon(
      Icons.star,
      color: Colors.amber,
      size: 16.0,
    );
  } else {
    return Icon(Icons.star_border, color: Colors.amber,size: 16.0);
  }
}

Widget objectDialog(BuildContext context,PracticeData jsonData,String imageName,ValueChanged<String> updateDonePracticeList) {
  return SimpleDialog(
    contentPadding: EdgeInsets.zero,
    children: [
      Container(
        height: 110,
        child: Image(image:AssetImage(imageName),
            fit: BoxFit.cover),
      ),

      Padding(
        padding: const EdgeInsets.fromLTRB(16.0,8.0,16.0,4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(jsonData.subject, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
            Text(jsonData.releaseDate,style:TextStyle(fontSize: 14,color: Colors.grey[600])),
          ],
        ),
      ),
      SizedBox(height: 4),
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0,4.0,16.0,4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(jsonData.simpleExplain, style: TextStyle(fontSize: 16),),
            Row(
              children: [
                _countStars(jsonData.stars, 1),
                _countStars(jsonData.stars, 2),
                _countStars(jsonData.stars, 3),
                _countStars(jsonData.stars, 4),
                _countStars(jsonData.stars, 5),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0,4.0,16.0,4.0),
        child: Container(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 12),
                Text('- Relative sections: ${jsonData.relativeSection}', style: TextStyle(fontSize: 16),),
                SizedBox(height: 12),
                Text(jsonData.content, style: TextStyle(fontSize: 16),),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () {Navigator.of(context).pop();},
              child: Text('Cancel',style:TextStyle(fontSize: 18,color: Colors.grey[600])),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,MaterialPageRoute(builder: (context) => StartPractice(jsonData: jsonData,updateDonePracticeList:updateDonePracticeList)));
              },
              child: Text('Start Practice',style:TextStyle(fontSize: 18,color: Colors.black)),
            )
          ],
        ),
      ),
    ]
  );
}
