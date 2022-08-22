import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../constants.dart';
import '../models/task.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);
  static bool deletePrevousDay = false;
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Task>('tasksBox');
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Tasks: ${box.values.length}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delete Tasks from prevous day'),
              CupertinoSwitch(
                  value: MenuPage.deletePrevousDay,
                  activeColor: primaryColor,
                  onChanged: ((value) {
                    setState(() {
                      MenuPage.deletePrevousDay = !MenuPage.deletePrevousDay;
                    });
                  }))
            ],
          )
        ],
      ),
    );
  }
}
