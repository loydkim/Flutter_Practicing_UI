import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'data.dart';

class StartPractice extends StatefulWidget{
  final PracticeData jsonData;
  final ValueChanged<String> updateDonePracticeList;
  StartPractice({this.jsonData,this.updateDonePracticeList});
  @override State<StatefulWidget> createState() => _StartPractice();
}

class _StartPractice extends State<StartPractice>{
  bool _isLoading = false;
  @override
  void initState() {
    _saveStartPracticeData();
    super.initState();
  }

  void _saveStartPracticeData() async{
    setState(() {
      _isLoading = true;
    });
    int newValue = DateTime.now().millisecondsSinceEpoch;
    var box = await Hive.openBox('doneData');
    DonePractice getPracticeDone = box.get('${widget.jsonData.type}Done');
    if(getPracticeDone != null){
      Map<String,int> doneData = getPracticeDone.doneData;
      if(doneData == null) {
        doneData = Map<String,int>();
        doneData[widget.jsonData.simpleExplain] = newValue;
      }else{
        bool _isExistValue = false;
        for(String key in doneData.keys){
          if(key == widget.jsonData.simpleExplain){
            _isExistValue = true;
            doneData[key] = newValue;
          }
        }
        if(!_isExistValue) doneData[widget.jsonData.simpleExplain] = newValue;
      }
      getPracticeDone.doneData = doneData;
      await box.put('${widget.jsonData.type}Done', getPracticeDone);
    }else{
      var newDonePractice = DonePractice()
        ..doneData = {widget.jsonData.simpleExplain:newValue};
      await box.put('${widget.jsonData.type}Done', newDonePractice);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> onBackPress() async{
    widget.updateDonePracticeList(widget.jsonData.type);
    Navigator.pop(context,true);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start ${widget.jsonData.type} Practice test'),
      ),
      body: WillPopScope(
        onWillPop: onBackPress,
        child:Stack(
          children: [
            Center(child: Text('Start ${widget.jsonData.type} practice test',style: TextStyle(fontSize: 24),)),
            _isLoading ? Positioned(
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                color: Colors.white.withOpacity(0.7),
              ),
            ) : Container()
          ],
        )
      )
    );
  }
}