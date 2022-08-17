import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id = const Uuid().v1();
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isCompleted;
  @HiveField(4)
  DateTime dateTime = DateTime.now();

  Task({
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });
}
