import 'package:flutter/material.dart';
import 'package:hive_todo_app/constants.dart';
import 'package:hive_todo_app/pages/calendar.dart';
import 'package:hive_todo_app/pages/home_screen.dart';
import 'package:hive_todo_app/pages/menu.dart';
import 'package:hive_todo_app/pages/projects.dart';
import 'package:iconsax/iconsax.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const ProjectPage(),
    const CalendarPage(),
    const MenuPage()
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: darkGreyColor,
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home_24), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.document_1), label: 'Projects'),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.calendar_1), label: 'Celendar'),
            BottomNavigationBarItem(icon: Icon(Iconsax.menu), label: 'Menu'),
          ]),
    );
  }
}
