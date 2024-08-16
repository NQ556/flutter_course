import 'package:isar/isar.dart';
part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;
  late String content;
}
