import 'package:jiffy/jiffy.dart';

extension FormatDate on DateTime {
  String yMMMEd() => Jiffy.parseFromDateTime(this).yMMMEd;
}
