import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_weather/data/models/task.dart';
import 'package:todo_list_weather/presentation/to_do/to_do_list_bloc/to_do_list_bloc.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    super.key,
  });

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool autoValidate = false;
  String category = 'Work';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var toDoListState = BlocProvider.of<ToDoListBloc>(context).state;

    return Container(
      height: 500,
      padding: const EdgeInsets.all(15),
//Form for adding new task
      child: Form(
          autovalidateMode: autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: ListView(children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              textAlign: TextAlign.center,
              controller: _titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Title must not be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  isCollapsed: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 104, 104)),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 248, 104, 104),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 248, 104, 104),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  )),
              onEditingComplete: () {
                if (_titleController.text.isNotEmpty) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(height: 20),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 20,
              minLines: 1,
              textAlign: TextAlign.center,
              controller: _descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Description must not be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  isCollapsed: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                  hintText: 'Description',
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 104, 104)),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 248, 104, 104),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 248, 104, 104),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  )),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton(
                  isDense: true,
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.all(10),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  underline: const Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  value: category,
                  style: Theme.of(context).textTheme.bodyMedium,
                  items: const [
                    DropdownMenuItem(
                      alignment: Alignment.center,
                      value: 'Work',
                      child: Text('Work'),
                    ),
                    DropdownMenuItem(
                      alignment: Alignment.center,
                      value: 'Personal',
                      child: Text('Personal'),
                    ),
                    DropdownMenuItem(
                      alignment: Alignment.center,
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  onChanged: (value) {
                    category = value!;
                    setState(() {});
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
              onPressed: () {
                setState(() {
                  autoValidate = true;
                });
                int amountTasks = 0;
                if (toDoListState is ToDoListLoaded) {
                  amountTasks = toDoListState.tasksList.length;
                }
                var task = Task(
                  id: amountTasks++,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  completed: false,
                  category: category,
                );
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  BlocProvider.of<ToDoListBloc>(context)
                      .add(AddTaskToList(task: task));
                  Navigator.pop(context);
                }
              },
              child: Text('Save',
                  style: Theme.of(context).primaryTextTheme.bodyLarge),
            ),
          ])),
    );
  }
}
