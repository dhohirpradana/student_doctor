import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_doctor/Database/dosen_db_provider.dart';
import 'package:student_doctor/Pages/add_pengajar_page.dart';
import 'package:student_doctor/Utils/Atom/color.dart';
import 'package:student_doctor/Utils/Atom/teks.dart';
import 'package:student_doctor/Utils/Func/Dosen/dosen_function.dart';
import 'package:student_doctor/Utils/Func/Navigator/navigator.dart';

class PengajarPage extends StatefulWidget {
  final String appBarTitle;

  const PengajarPage({Key key, @required this.appBarTitle}) : super(key: key);
  @override
  _PengajarPageState createState() => _PengajarPageState();
}

class _PengajarPageState extends State<PengajarPage> {
  @override
  void initState() {
    super.initState();
    // dosenDb.deleteDosen(4);
  }

  @override
  Widget build(BuildContext context) {
    DosenDbProvider dosenDb = DosenDbProvider();
    return ScreenUtilInit(
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: teks(teks: widget.appBarTitle),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            navigatorPush(context, AddPengajarPage());
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder<List>(
            future: dosenDb.fetchDosenToModel(),
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
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data.nama,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.bold),
                                ),
                                decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15)),
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
                                        desc:
                                            'Ada ingin menghapus data Dosen ini?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          setState(() {
                                            deleteDosen(data.id);
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
      ),
    );
  }
}
