import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_doctor/Database/mk_db_provider.dart';
import 'package:student_doctor/Pages/add_mk_page.dart';
import 'package:student_doctor/Pages/task_page.dart';
import 'package:student_doctor/Utils/Atom/color.dart';
import 'package:student_doctor/Utils/Atom/screen_utils_size.dart';
import 'package:student_doctor/Utils/Atom/teks.dart';
import 'package:student_doctor/Utils/Func/Navigator/navigator.dart';

class MKPage extends StatefulWidget {
  final String appBarTitle;

  const MKPage({Key key, @required this.appBarTitle}) : super(key: key);
  @override
  _MKPageState createState() => _MKPageState();
}

class _MKPageState extends State<MKPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MKDbProvider mkDb = MKDbProvider();
    return ScreenUtilInit(
      builder: () => Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: teks(teks: widget.appBarTitle),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () {
              navigatorPush(context, AddMKPage());
            },
            child: Icon(Icons.add),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder<List>(
              future: mkDb.fetchMK(),
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
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, int index) {
                            final data = snapshot.data[index];
                            return GestureDetector(
                              onTap: () {
                                navigatorPush(context,
                                    TaskPage(mkId: data.id, mkNama: data.nama));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(screenUtilSize(15)),
                                      child: Text(
                                        data.nama,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      data.pengajar,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.all(screenUtilSize(15)),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          data.hari + ' ' + data.waktu,
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          )),
    );
  }
}
