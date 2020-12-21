import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'data.dart';
import 'objectDialog.dart';

class ShowDataAsList extends StatefulWidget{
  final List<List<PracticeData>> data;
  final ValueChanged<String> updateMyData;
  ShowDataAsList({this.data,this.updateMyData});
  @override State<StatefulWidget> createState() => _ShowDataAsList();
}

class _ShowDataAsList extends State<ShowDataAsList>  with TickerProviderStateMixin{

  String myThumbnail;

  TabController _tabController;
  void _handleTabSelection() => setState(() {});

  bool _isLoading = false;
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  List<PracticeData> _temporaryDataList;
  Future<void> _updateDonePracticeList(String dataType) async{
    setState(() {
      _isLoading = true;
    });
    switch (dataType){
      case "Listening":{_temporaryDataList = widget.data[0]; }break;
      case "Reading":{_temporaryDataList = widget.data[1]; } break;
      case "Speaking":{_temporaryDataList = widget.data[2]; }break;
      case "Writing":{_temporaryDataList = widget.data[3]; } break;
    }
    var box = await Hive.openBox('doneData');
    DonePractice getPracticeDone = box.get('${dataType}Done');

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
      _temporaryDataList.sort((a,b) {
        return a.doneDateMilliSecond.compareTo(b.doneDateMilliSecond);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ColorFilter greyColorFilter = ColorFilter.matrix(<double>[
      0.2126,0.7152,0.0722,0,0,
      0.2126,0.7152,0.0722,0,0,
      0.2126,0.7152,0.0722,0,0,
      0,0,0,1,0,
    ]);
    List<Padding> _tabIconList = [
      Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(child: ColorFiltered(child: Image.asset('images/icon_listening.png'),colorFilter: _tabController.index != 0 ? greyColorFilter : ColorFilter.mode(Colors.transparent, BlendMode.color))),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(child: ColorFiltered(child: Image.asset('images/icon_reading.png'),colorFilter:_tabController.index != 1 ? greyColorFilter : ColorFilter.mode(Colors.transparent, BlendMode.color))),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(child: ColorFiltered(child: Image.asset('images/icon_spaking.png'),colorFilter:_tabController.index != 2 ? greyColorFilter : ColorFilter.mode(Colors.transparent, BlendMode.color))),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(child: ColorFiltered(child: Image.asset('images/icon_writing.png'),colorFilter:_tabController.index != 3 ? greyColorFilter : ColorFilter.mode(Colors.transparent, BlendMode.color))),
      ),
    ];


    return Stack(
      children: <Widget>[
        SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: [
                _isLoading ? Container() : Container(
                    width: size.width,
                    height: size.height-size.height*0.1,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.black87,
                              tabs: [
                                Tab(child: _tabIconList[0]),
                                Tab(child: _tabIconList[1]),
                                Tab(child: _tabIconList[2]),
                                Tab(child: _tabIconList[3]),
                              ],
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  ListView(
                                    children: widget.data[0].map((data) => _makeListTile(data)).toList(),
                                  ),
                                  // _makeListTile('123'),
                                  ListView(
                                    children: widget.data[1].map((data) => _makeListTile(data)).toList(),
                                  ),
                                  ListView(
                                    children: widget.data[2].map((data) => _makeListTile(data)).toList(),
                                  ),
                                  ListView(
                                    children: widget.data[3].map((data) => _makeListTile(data)).toList(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ),
                _isLoading ? Positioned(
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                    color: Colors.white.withOpacity(0.7),
                  ),
                ): Container()
              ],
            )
          ]
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:2.0,right:2.0),
                child: ClipOval(
                  child: Container(
                    color: Colors.blue,
                    height: 60.0, // height of the button
                    width: 60.0, // width of the button
                    child: RaisedButton(
                      elevation:8.0,
                      color: Colors.black,
                      onPressed: (){
                        Navigator.pop(context,myThumbnail);
                      },
                      child: Icon(Icons.close,size: 32,color: Colors.white,),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ]
    );
  }

  Widget _makeListTile(PracticeData practiceData){
    return ListTile(
      onTap: (){
        showDialog(
          context: context,
          builder: (context) => objectDialog(context,practiceData,practiceData.dialogImage,_updateDonePracticeList));
      },
      // leading: Text('leading'),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(practiceData.subject,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: practiceData.isFinished ? Colors.grey[600] : Colors.black),),
              Text(practiceData.releaseDate,style:TextStyle(fontSize: 14,color: Colors.grey[600])),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' ${practiceData.simpleExplain}',style: TextStyle(fontSize: 15,color: practiceData.isFinished ? Colors.grey[600] : Colors.black)),
              Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Row(
                  children: [
                    _countStars(practiceData, 1),
                    _countStars(practiceData, 2),
                    _countStars(practiceData, 3),
                    _countStars(practiceData, 4),
                    _countStars(practiceData, 5),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Icon _countStars(PracticeData data, int index) {
    if (index <= data.stars) {
      return Icon(
        Icons.star,
        color:  data.isFinished ? Colors.amber[300]: Colors.amber,
        size: 16.0,
      );
    } else {
      return Icon(Icons.star_border, color:data.isFinished ? Colors.amber[300]:Colors.amber,size: 16.0);
    }
  }
}