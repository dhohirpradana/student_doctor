import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_doctor/Database/task_db_provider.dart';
import 'package:student_doctor/Utils/Atom/color.dart';
import 'package:student_doctor/Utils/Atom/screen_utils_size.dart';
import 'package:student_doctor/Utils/Atom/teks.dart';
import 'package:student_doctor/Utils/Func/Task/task_function.dart';
import 'package:student_doctor/Utils/Func/Time/timestamp_func.dart';

class AllTaskPage extends StatefulWidget {
  final appBarTitle;

  const AllTaskPage({Key key, this.appBarTitle}) : super(key: key);
  @override
  _AllTaskPageState createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  @override
  void initState() {
    super.initState();
  }

  TaskDbProvider taskDb = TaskDbProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: teks(teks: widget.appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: FutureBuilder<List>(
          future: taskDb.fetchTask(),
          // ignore: deprecated_member_use
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      // disable scroll glow effect
                      notification.disallowGlow();
                    },
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, int index) {
                        final data = snapshot.data[index];
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(
                                  screenUtilSize(9),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        data.mkNama.toString(),
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(data.value)),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        readTimestamp(data.deadline),
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  alignment: Alignment.bottomRight,
                                  onPressed: () {
                                    AwesomeDialog(
                                      dismissOnTouchOutside: false,
                                      context: context,
                                      dialogType: DialogType.WARNING,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'HAPUS',
                                      desc: 'Ada ingin menghapus Tugas ini?',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        setState(() {
                                          deleteTask(data.id);
                                        });
                                        AwesomeDialog(
                                          dismissOnTouchOutside: false,
                                          context: context,
                                          animType: AnimType.SCALE,
                                          dialogType: DialogType.SUCCES,
                                          title: 'SUCCES',
                                          desc: 'Hapus data berhasil',
                                          btnOkOnPress: () {},
                                        )..show();
                                      },
                                    )..show();
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red[300],
                                    size: ScreenUtil().setSp(20),
                                  )),
                            )
                          ],
                        );
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
