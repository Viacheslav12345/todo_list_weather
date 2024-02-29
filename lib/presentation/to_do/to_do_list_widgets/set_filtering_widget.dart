import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_weather/presentation/to_do/to_do_list_bloc/to_do_list_bloc.dart';

class SetFiltering extends StatefulWidget {
  const SetFiltering({super.key});

  @override
  State<SetFiltering> createState() => _SetFilteringState();
}

class _SetFilteringState extends State<SetFiltering> {
  int _groupCompleted = -1;
  int _groupCategory = 3;
  String _category = 'All';

  List listOfGroupCompleted = [
    {'label': 'Completed', 'value': 0},
    {'label': "Not completed", 'value': 1}
  ];

  List listOfGroupCategory = [
    {'label': 'Work', 'value': 0},
    {'label': "Personal", 'value': 1},
    {'label': "Other", 'value': 2},
    {'label': "All", 'value': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoListBloc, ToDoListState>(
      builder: (context, state) {
        var currentState = state;
        if (currentState is ToDoListFiltering) {
          _groupCompleted = (currentState.filteringByStatusComplete)
              ? 0
              : (currentState.filteringByStatusNotComplete)
                  ? 1
                  : -1;
          _groupCategory = listOfGroupCategory.firstWhere((element) =>
              element['label'] == currentState.categoryFilter)['value'];
        }
        return Container(
          height: 500,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            color: Theme.of(context).secondaryHeaderColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text('Filtering',
                    style: Theme.of(context).textTheme.titleLarge),
                const Divider(thickness: 2),
                Text(
                  'By Completed',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                for (var item in listOfGroupCompleted)
                  Column(children: [
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        value: item['value'],
                        groupValue: _groupCompleted,
                        onChanged: (newValue) => setState(() {
                          _groupCompleted = newValue!;
                          BlocProvider.of<ToDoListBloc>(context)
                              .add(GetTaskList());
                          BlocProvider.of<ToDoListBloc>(context).add(
                              FilteringTaskList(
                                  filteringByStatusComplete:
                                      _groupCompleted == 0,
                                  filteringByStatusNotComplete:
                                      _groupCompleted == 1,
                                  categoryFilter: _category));
                        }),
                        title: Text(item['label']),
                      ),
                    ),
                  ]),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                ),
                Text(
                  'By Category',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                for (var item in listOfGroupCategory)
                  Column(children: [
                    SizedBox(
                      height: 40,
                      child: RadioListTile(
                        value: item['value'],
                        groupValue: _groupCategory,
                        onChanged: (newValue) => setState(() {
                          _groupCategory = newValue!;
                          _category = item['label'];
                          BlocProvider.of<ToDoListBloc>(context)
                              .add(GetTaskList());
                          BlocProvider.of<ToDoListBloc>(context).add(
                              FilteringTaskList(
                                  filteringByStatusComplete:
                                      _groupCompleted == 0,
                                  filteringByStatusNotComplete:
                                      _groupCompleted == 1,
                                  categoryFilter: _category));
                        }),
                        title: Text(item['label']),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge)),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColorDark)),
                          onPressed: () {
                            BlocProvider.of<ToDoListBloc>(context)
                                .add(GetTaskList());
                            Navigator.pop(context);
                          },
                          child: Text('To clear',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
