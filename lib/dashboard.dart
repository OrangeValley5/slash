import 'package:flutter/material.dart';
import 'package:slash/home.dart';
import 'package:slash/invite.dart';
import 'package:slash/mine.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String message = '';
  int myIndex = 0;
  List<Widget> widgetList = const [
    Home(),
    Invite(),
    Minne(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF8552),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
            onTap: (index) => {
              setState(() {
                myIndex = index;
              })
            },
            currentIndex: myIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 18,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                  size: 20,
                ),
                label: 'Invite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.handyman,
                  size: 20,
                ),
                label: 'Mine',
              ),
            ],
            selectedFontSize: 11,
            unselectedFontSize: 10,
            selectedItemColor: Color(0xFF85FFC7), // Set selected item color
            unselectedItemColor: Color(0xFFE1E1E1),
            showSelectedLabels: true,
            elevation: 0,
            showUnselectedLabels: true,
            backgroundColor: Color(0xFF297373),
            // Set unselected item color
          ),
        ),
      ),
      body: IndexedStack(
        children: widgetList,
        index: myIndex,
      ),
    );
  }
}
