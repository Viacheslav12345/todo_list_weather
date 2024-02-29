import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list_weather/data/models/task.dart';
import 'package:todo_list_weather/presentation/to_do/to_do_list_bloc/to_do_list_bloc.dart';
import 'package:todo_list_weather/presentation/to_do/to_do_list_widgets/add_task_widget.dart';
import 'package:todo_list_weather/presentation/to_do/to_do_list_widgets/set_filtering_widget.dart';
import 'package:todo_list_weather/presentation/weather/weather_main_widget.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key, required this.title});

  final String title;

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  void _addTask() {
    showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
              insetPadding: EdgeInsets.all(20), child: AddTask());
        });
  }

  void _showFiltering() {
    showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
              insetPadding: EdgeInsets.all(20), child: SetFiltering());
        });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
// Showing weather
        flexibleSpace: const WeatherWidget(),
      ),
      body: BlocBuilder<ToDoListBloc, ToDoListState>(
        builder: (context, state) {
          List<Task> tasksList = [];
          if (state is ToDoListLoaded) {
            tasksList = state.tasksList;
          } else if (state is ToDoListFiltering) {
            tasksList = state.tasksList;
          }
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: tasksList.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        BlocProvider.of<ToDoListBloc>(context)
                            .add(RemoveTaskFromList(task: tasksList[index]));
                      }),
                      children: [
                        SlidableAction(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          onPressed: (context) {
//Removing current Task from list
                            BlocProvider.of<ToDoListBloc>(context).add(
                                RemoveTaskFromList(task: tasksList[index]));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 248, 104, 104),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      color: tasksList[index].completed
                          ? Colors.green[50]
                          : Colors.red[50],
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: tasksList[index].completed,
                                    onChanged: (value) {
// Changing Status of current Task
                                      BlocProvider.of<ToDoListBloc>(context)
                                          .add(ChangeStatusTaskInList(
                                              taskId: tasksList[index].id));
                                    }),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
//Showing Title fo current Task
                                        Text(
                                          tasksList[index].title,
                                          style: textTheme.titleLarge,
                                        ),
//Showing Description fo current Task
                                        Text(
                                          tasksList[index].description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10),
//Showing Category fo current Task
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              child: Chip(
                                                padding: EdgeInsets.zero,
                                                label: Text(
                                                  tasksList[index].category,
                                                  style: textTheme.labelSmall,
                                                ),
                                                color: tasksList[index]
                                                            .category ==
                                                        'Work'
                                                    ? MaterialStateProperty.all(
                                                        Colors.green[300])
                                                    : tasksList[index]
                                                                .category ==
                                                            'Personal'
                                                        ? MaterialStateProperty
                                                            .all(
                                                                Colors.red[300])
                                                        : MaterialStateProperty
                                                            .all(Colors
                                                                .blue[300]),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              });
        },
      ),
      floatingActionButton:
          BlocBuilder<ToDoListBloc, ToDoListState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                backgroundColor: (state is ToDoListFiltering)
                    ? Colors.red[100]
                    : Colors.blue[100],
                onPressed: () {
                  _showFiltering();
                },
                tooltip: 'Filter',
                child: const Icon(Icons.filter_list),
              ),
//Adding new Task button
              FloatingActionButton(
                onPressed: () {
                  _addTask();
                },
                tooltip: 'Add',
                child: const Icon(Icons.add),
              ),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
