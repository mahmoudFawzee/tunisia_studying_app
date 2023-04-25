// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';
part 'homework.g.dart';

@HiveType(typeId: 0)
class Homework extends HiveObject {
  @HiveField(0)
  late String homeworkName;
  @HiveField(1)
  late bool done;
  @HiveField(2)
  late DateTime homeworkTime;

  String dateTimeString() {
    String duration = _pmOrAm(homeworkTime.hour);
    return '${homeworkTime.month}/${homeworkTime.day} - ${_formatHour(homeworkTime.hour)}:${homeworkTime.minute} $duration';
  }

  int _formatHour(int hour) {
    if (hour > 12) {
      return hour - 12;
    }
    return hour;
  }

  String _pmOrAm(int hour) {
    if (hour < 12) return 'ًص';
    return 'م';
  }
}
