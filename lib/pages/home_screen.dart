import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/widgets/button.dart';
import 'package:iconsax/iconsax.dart';
import '../constants.dart';
import '../models/task.dart';
import '../widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titleFormKey = GlobalKey<FormState>();
  final _descriptionFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isEditing = false;
  bool isCompleted = false;
  void showAddTaskBottomSheet({int? index}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return SizedBox(
                height: 600,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      isEditing ? 'Edit Task' : 'Add Task',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Title',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextField(
                            contoller: titleController,
                            validatorText: 'Please enter the title',
                            formKey: _titleFormKey,
                            hintText: 'task title',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextField(
                              formKey: _descriptionFormKey,
                              hintText: 'task description',
                              validatorText: '',
                              contoller: descriptionController)
                        ],
                      ),
                    ),
                    const Spacer(),
                    AppButton(
                        buttonText: isEditing ? 'Edit' : 'Add',
                        onPressed: () {
                          if (_titleFormKey.currentState!.validate()) {
                            Box<Task> taskBox = Hive.box<Task>('tasksBox');
                            if (isEditing) {
                              taskBox.putAt(
                                  index!,
                                  Task(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      isCompleted: isCompleted));
                            } else {
                              taskBox.add(Task(
                                  title: titleController.text,
                                  description: descriptionController.text));
                            }
                            Navigator.pop(context);
                          }
                        }),
                    const Spacer()
                  ],
                ),
              );
            },
          );
        });
  }

  void undoChange(Box<Task> box, dynamic obj, int index) {
    box.putAt(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
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
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Task deleted!'),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  undoChange(box, task, index);
                                },
                                style: TextButton.styleFrom(
                                    side: const BorderSide(width: 1)),
                                child: const Text(
                                  'Undo',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                      resizeDuration: const Duration(milliseconds: 2500),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        task!.delete();
                      },
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: greyColor,
                              blurRadius: 10,
                              offset: Offset(0, 7))
                        ]),
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          child: ListTile(
                            title: Text(
                              task!.title,
                              style: task.isCompleted
                                  ? TextStyle(
                                      fontSize: textTheme.titleMedium!.fontSize,
                                      color: Colors.black87,
                                      decoration: TextDecoration.lineThrough)
                                  : textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              task.description,
                              style: textTheme.labelMedium,
                            ),
                            leading: task.isCompleted
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                    ),
                                    onPressed: () => setState(() {
                                      isCompleted = !isCompleted;
                                      task.isCompleted = !task.isCompleted;
                                      task.save();
                                    }),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.circle_outlined),
                                    onPressed: () => setState(() {
                                      isCompleted = !isCompleted;
                                      task.isCompleted = !task.isCompleted;
                                      task.save();
                                    }),
                                  ),
                            onTap: () {
                              setState(() {
                                isEditing = true;
                                titleController.text = task.title;
                                descriptionController.text = task.description;
                              });

                              showAddTaskBottomSheet(index: index);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              isEditing = false;
              titleController.text = '';
              descriptionController.text = '';
            });

            showAddTaskBottomSheet();
          },
          elevation: 0,
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
