import 'package:hive_flutter/hive_flutter.dart';
part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  Note({required this.title, required this.content});
}
