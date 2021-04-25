import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_doctor/Utils/Atom/color.dart';
import 'package:student_doctor/Utils/Atom/gap.dart';
import 'package:student_doctor/Utils/Func/Task/task_function.dart';
import 'package:student_doctor/Utils/Molekul/date_time_picker.dart';
import 'package:student_doctor/Utils/Molekul/slider.dart';

class TaskPage extends StatefulWidget {
  final mkId, mkNama;

  const TaskPage({Key key, @required this.mkId, @required this.mkNama})
      : super(key: key);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime chosenDateTime = DateTime.now();
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.mkNama.toString().toUpperCase()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {
          createTask(
              mkId: widget.mkId,
              value: 'COBA-COBA',
              deadline: chosenDateTime,
              progress: _currentSliderValue);
        },
        child: Icon(Icons.add),
      ),
      body: Column(children: [
        Expanded(
          child: dateTime((val) {
            setState(() {
              chosenDateTime = val;
            });
          }),
        ),
        Text(
          "Progress",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.w600),
        ),
        slider(context, _currentSliderValue, (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        }),
        gap(tinggi: ScreenUtil().setSp(14))
      ]),
    );
  }
}
