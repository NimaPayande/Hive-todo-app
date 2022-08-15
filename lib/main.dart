import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/models/task.dart';
import 'package:hive_todo_app/pages/main_page.dart';
import './constants.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('tasksBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        useMaterial3: true,
        textTheme: TextTheme(
            displayLarge: GoogleFonts.dmSans(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            displayMedium:
                GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.bold),
            titleLarge:
                GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.bold),
            titleMedium:
                GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w500),
            bodyMedium:
                GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w500),
            labelMedium: GoogleFonts.dmSans(fontSize: 14),
            labelSmall: GoogleFonts.dmSans(fontSize: 12)),
        buttonTheme: const ButtonThemeData(
          buttonColor: primaryColor,
          disabledColor: greyColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
