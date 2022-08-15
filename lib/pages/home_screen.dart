import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Task>('tasksBox').listenable(),
          builder: (context, Box<Task> box, _) {
            if (box.isEmpty) {
              return const Center(child: Text('No Task...'));
            }
            return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  Task? task = box.getAt(index);
                  return Dismissible(
                    background: Container(color: Colors.red),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      task!.delete();
                    },
                    child: ListTile(
                      title: Text(task?.title ?? ''),
                      leading: task!.isCompleted
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank_sharp),
                      onTap: () => setState(() {
                        task.isCompleted = true;
                        task.save();
                      }),
                    ),
                  );
                });
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
