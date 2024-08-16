import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class ToDo {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  ToDo(this.title, this.content);
}
