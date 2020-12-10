import 'package:flutter/material.dart';
import 'package:practicinguitwo/practiceItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PracticeItemStructure{
  final String imageName;
  final String title;
  final String subTitle;
  final String task;
  final Color bgColor;
  final String date;
  final String subject;
  const PracticeItemStructure({this.imageName,this.title,this.subTitle,this.task,this.bgColor,this.date,this.subject});
}

List<PracticeItemStructure> practicingData = [
  new PracticeItemStructure(imageName: 'images/icon_listening.png',title: 'Listening',subTitle: 'Improve listening',bgColor: Colors.purple),
  new PracticeItemStructure(imageName: 'images/icon_reading.png',title: 'Reading',subTitle: 'Reading article',bgColor: Colors.indigo),
  new PracticeItemStructure(imageName: 'images/icon_spaking.png',title: 'Speaking',subTitle: 'Practicing pronunciation',bgColor: Colors.green[200]),
  new PracticeItemStructure(imageName: 'images/icon_writing.png',title: 'Writing',subTitle: 'Learn Writing form',bgColor: Colors.brown[400]),
];

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice UI Two'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: practicingData.map((data) => PracticeItem(data:data)).toList()
        ),
      ),
    );
  }
}
