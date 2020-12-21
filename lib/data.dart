import 'package:hive/hive.dart';

class PracticeData{
  String type;
  String subject;
  String simpleExplain;
  int stars;
  String releaseDate;
  int practiceTime;
  String relativeSection;
  String content;
  bool isFinished;
  int doneDateMilliSecond;
  String iconName;
  String dialogImage;

  PracticeData({
    this.type,
    this.subject,
    this.simpleExplain,
    this.stars,
    this.releaseDate,
    this.practiceTime,
    this.relativeSection,
    this.content,
    this.isFinished,
    this.doneDateMilliSecond,
    this.iconName,
    this.dialogImage
  });
}


@HiveType(typeId: 1)
class DonePractice {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  List<String> friends;

  @HiveField(3)
  Map<String,int> doneData;
}

class DonePracticeAdapter extends TypeAdapter<DonePractice> {
  @override
  final typeId = 1;

  @override
  DonePractice read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonePractice()
      ..name = fields[0] as String
      ..age = fields[1] as int
      ..friends = (fields[2] as List)?.cast<String>()
      ..doneData = (fields[3] as Map)?.cast<String,int>();
  }

  @override
  void write(BinaryWriter writer, DonePractice obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.friends)
      ..writeByte(3)
      ..write(obj.doneData);
  }
}

enum PracticeType{
  LISTENING,
  READING,
  SPEAKING,
  WRITING,
}

List<String> practiceTitleList = ["Listening","Reading","Speaking","Writing"];