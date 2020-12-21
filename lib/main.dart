import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practicinguitwo/practiceTwoItem.dart';

import 'commonWidgets.dart';
import 'data.dart';
import 'practiceOneItem.dart';
import 'showDataAsList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  List<List<PracticeData>> _totalPracticeDataList;
  List<PracticeData> _practiceListeningDataList = List<PracticeData>();
  List<PracticeData> _practiceReadingDataList = List<PracticeData>();
  List<PracticeData> _practiceSpeakingDataList = List<PracticeData>();
  List<PracticeData> _practiceWritingDataList = List<PracticeData>();

  TabController _tabController;
  bool _isLoading = false;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
    _totalPracticeDataList = [_practiceListeningDataList,_practiceReadingDataList,_practiceSpeakingDataList,_practiceWritingDataList];
    setState(() {
      _isLoading = true;
    });
    _initData();
    super.initState();
  }

  Future<void> _initData() async{
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    var path = appDocDirectory.path;
    Hive..init(path)..registerAdapter(DonePracticeAdapter());
    await _initListData();
  }

  void _handleTabSelection() => setState(() {});

  void onTabTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  Future<void> _initListData() async{
    for(String title in practiceTitleList) { await _takeJsonData(title); }
    if(_isLoading) setState(() => _isLoading = false);
  }

  List<PracticeData> _temporaryDataList;
  Future<void> _takeJsonData(String type) async{
    _setTemporaryDataListFromTitleList(type);
    String data = await DefaultAssetBundle.of(context).loadString("json/${type.toLowerCase()}Data.json");
    final jsonResult = json.decode(data);
    for (Map<String,dynamic> examData in jsonResult) {
      PracticeData data = PracticeData(
          type: examData['type'],
          subject: examData['subject'],
          simpleExplain: examData['simpleExplain'],
          stars: examData['stars'],
          releaseDate: examData['releaseDate'],
          practiceTime: examData['practiceTime'],
          relativeSection: examData['relativeSection'],
          content:examData['content'],
          isFinished:false,
          doneDateMilliSecond: 0,
          dialogImage: examData['dialogImage'],
          iconName:examData['iconName'],
      );
      _temporaryDataList.add(data);
    }

    await _updateDonePracticeList(type);
  }

  Future<void> _updateDonePracticeList(String type) async{
    _setTemporaryDataListFromTitleList(type);
    var box = await Hive.openBox('doneData');
    DonePractice getPracticeDone = box.get('${type}Done');

    if(getPracticeDone != null){
      Map<String,int> _doneData = getPracticeDone.doneData;
      if(_doneData != null && _doneData.length > 0){
        for(PracticeData data in _temporaryDataList){
          for(String key in _doneData.keys){
            if(data.simpleExplain == key){
              data.isFinished = true;
              data.doneDateMilliSecond = _doneData[key];
            }
          }
        }
      }
      _temporaryDataList.sort((a,b) => a.doneDateMilliSecond.compareTo(b.doneDateMilliSecond));
    }
  }
  
  void _setTemporaryDataListFromTitleList(String type){
    switch (type){
      case "Listening":{_temporaryDataList = _practiceListeningDataList; }break;
      case "Reading":{_temporaryDataList = _practiceReadingDataList; } break;
      case "Speaking":{_temporaryDataList = _practiceSpeakingDataList; }break;
      case "Writing":{_temporaryDataList = _practiceWritingDataList; } break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice UI'),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.view_list, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ShowDataAsList(data: _totalPracticeDataList),
              barrierDismissible: true,
            ).then((value) {for(String title in practiceTitleList) { _updateDonePracticeList(title); }});
          },
        ),
      ),
      body: Stack(
        children: [
          _isLoading ? Container() : TabBarView(
            controller: _tabController,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _totalPracticeDataList.map((data) => PracticeOneItem(data:data,updateMyData: _updateDonePracticeList,)).toList()
                ),
              ),
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _totalPracticeDataList.map((data) => PracticeTwoItem(data:data,updateMyData: _updateDonePracticeList,)).toList()
                ),
              ),
            ]
          ),
          _isLoading ? CommonWidgets.loadingCircle(): Container()
        ],
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
