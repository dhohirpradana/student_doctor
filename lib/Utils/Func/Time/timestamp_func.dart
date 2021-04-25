import 'package:intl/intl.dart';

String readTimestamp(ts) {
  var now = new DateTime.now();
  var format = new DateFormat('hh:mm a');
  final f = new DateFormat('yyyy-MM-dd hh:mm a');
  var date = new DateTime.fromMicrosecondsSinceEpoch(ts * 1000);
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final aDate = DateTime(date.year, date.month, date.day);
  var time = '';

  if (aDate == today) {
    time = format.format(date);
  } else if (aDate == yesterday) {
    time = 'Kemarin ' + format.format(date);
  } else if (aDate == tomorrow) {
    time = 'Besok ' + format.format(date);
  } else {
    time = f.format(date);
  }
  return time;
}

// String readTimestamp() {
//   var timestamp = DateTime.now().millisecondsSinceEpoch;
//   var now = new DateTime.now();
//   var format = new DateFormat('HH:mm a');
//   var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
//   var diff = date.difference(now);
//   var time = '';

//   if (diff.inSeconds <= 0 ||
//       diff.inSeconds > 0 && diff.inMinutes == 0 ||
//       diff.inMinutes > 0 && diff.inHours == 0 ||
//       diff.inHours > 0 && diff.inDays == 0) {
//     time = format.format(date);
//   } else {
//     if (diff.inDays == 1) {
//       time = diff.inDays.toString() + 'Hari yang lalu';
//     } else {
//       time = diff.inDays.toString() + 'Hari yang lalu';
//     }
//   }
//   return time;
// }
