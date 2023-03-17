import 'package:hive/hive.dart';
part 'NotesModal.g.dart';

@HiveType(typeId: 0)
class Notes {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? time;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? body;
  Notes({this.id,this.title, this.body, this.time});
}
