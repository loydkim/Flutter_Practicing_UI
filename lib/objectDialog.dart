import 'package:flutter/material.dart';


Widget objectDialog(BuildContext context, String imageName, String title, String explain) {
  ThemeData localTheme = Theme.of(context);
  return SimpleDialog(
    contentPadding: EdgeInsets.zero,
    children: [
      Container(
        height: 130,
        child: Image(image:AssetImage(imageName),
            fit: BoxFit.cover),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
            SizedBox(height: 12),
            Text(explain, style: TextStyle(fontSize: 16),),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel',style:TextStyle(fontSize: 18,color: Colors.grey[600])),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Start Practice',style:TextStyle(fontSize: 18,color: Colors.black)),
                  )
                ],
              ),
            )
          ],
        ),
      )
    ]
  );
}
