import 'package:flutter/material.dart';
import 'package:student_doctor/Pages/all_task_page.dart';
import 'package:student_doctor/Pages/mk_page.dart';
import 'package:student_doctor/Pages/pengajar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MKPage(appBarTitle: "MATA KULIAH"),
    AllTaskPage(
      appBarTitle: "TUGAS",
    ),
    Text(
      'Jadwal',
      style: optionStyle,
    ),
    PengajarPage(
      appBarTitle: "DOSEN",
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Dosen',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF00CA71),
        unselectedItemColor: Colors.blueGrey[200],
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
