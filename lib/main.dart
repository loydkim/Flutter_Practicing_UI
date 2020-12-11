import 'package:flutter/material.dart';
import 'package:practicinguitwo/practiceTwoItem.dart';
import 'package:practicinguitwo/practiceOne.dart';

import 'practiceTwo.dart';

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
enum PracticeType{
  LISTENING,
  READING,
  SPEAKING,
  WRITING
}
class PracticeItemStructure{
  final String imageName;
  final String title;
  final String subTitle;
  final String task;
  final Color bgColor;
  final String date;
  final String subject;
  final PracticeType type;
  final String dialogImage;
  const PracticeItemStructure({this.imageName,this.title,this.subTitle,this.task,this.bgColor,this.date,this.subject,this.type,this.dialogImage});
}

List<PracticeItemStructure> practicingOneData = [
  new PracticeItemStructure(imageName: 'images/listening.jpg',title: 'Listening',subTitle: 'Improve listening',bgColor: Colors.purple,dialogImage: 'images/listening.jpg'),
  new PracticeItemStructure(imageName: 'images/reading.jpg',title: 'Reading',subTitle: 'Reading article',bgColor: Colors.indigo,dialogImage: 'images/reading.jpg'),
  new PracticeItemStructure(imageName: 'images/speaking.jpg',title: 'Speaking',subTitle: 'Practicing pronunciation',bgColor: Colors.green[200],dialogImage: 'images/speaking.jpg'),
  new PracticeItemStructure(imageName: 'images/writing.jpg',title: 'Writing',subTitle: 'Learn Writing form',bgColor: Colors.brown[400],dialogImage: 'images/writing.jpg'),
];

List<PracticeItemStructure> practicingTwoData = [
  new PracticeItemStructure(imageName: 'images/icon_listening.png',title: 'Listening',subTitle: 'Improve listening',bgColor: Colors.purple,dialogImage: 'images/listening.jpg'),
  new PracticeItemStructure(imageName: 'images/icon_reading.png',title: 'Reading',subTitle: 'Reading article',bgColor: Colors.indigo,dialogImage: 'images/reading.jpg'),
  new PracticeItemStructure(imageName: 'images/icon_spaking.png',title: 'Speaking',subTitle: 'Practicing pronunciation',bgColor: Colors.green[200],dialogImage: 'images/speaking.jpg'),
  new PracticeItemStructure(imageName: 'images/icon_writing.png',title: 'Writing',subTitle: 'Learn Writing form',bgColor: Colors.brown[400],dialogImage: 'images/writing.jpg'),
];

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {

    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() => setState(() {});

  void onTabTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice UI'),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.history_edu, color: Colors.white),
          onPressed: () {
            print('left icon of the app title');
          },
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.view_list, color: Colors.white),
            onPressed: () {
              print('right icon of the app title');
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PracticeOne(),
          PracticeTwo()
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _tabController.index,
        selectedItemColor: Colors.amber[900],
        unselectedItemColor: Colors.grey[800],
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.whatshot),
            title: new Text('UI 1'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.border_color),
            title: new Text('UI 2'),
          ),
        ],
      ),
    );
  }
}
