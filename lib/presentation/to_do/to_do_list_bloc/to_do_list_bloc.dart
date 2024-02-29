// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_list_weather/data/services/local_storage_service.dart';
import 'package:todo_list_weather/data/models/task.dart';

part 'to_do_list_event.dart';
part 'to_do_list_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  LocalStorageService localDataSource;
  ToDoListBloc(
    this.localDataSource,
  ) : super(ToDoListInitial()) {
    on<ToDoListEvent>((event, emit) {});

    on<AddTaskToList>((event, emit) {
      var currentState = state;
      List<Task> tasksList = [];
      if (currentState is ToDoListLoaded) {
        tasksList = currentState.tasksList;
      }
      emit(ToDoListLoading());
      tasksList.add(event.task);
      localDataSource.setTasksToCache(tasksList);
      emit(ToDoListLoaded(tasksList: tasksList));
    });

    on<GetTaskList>((event, emit) {
      emit(ToDoListLoading());
      List<Task> tasksList = localDataSource.getTasksFromCache();
      emit(ToDoListLoaded(tasksList: tasksList));
    });

    on<RemoveTaskFromList>((event, emit) {
      var currentState = state;
      List<Task> tasksList = [];
      if (currentState is ToDoListLoaded) {
        tasksList = currentState.tasksList;
      }
      if (tasksList.isNotEmpty) {
        emit(ToDoListLoading());
        tasksList.remove(event.task);
        localDataSource
            .setTasksToCache(tasksList)
            .then((_) => emit(ToDoListLoaded(tasksList: tasksList)));
      }
    });

    on<ChangeStatusTaskInList>(
      (event, emit) {
        var currentState = state;
        List<Task> tasksList = [];
        if (currentState is ToDoListLoaded) {
          tasksList = currentState.tasksList;
        }
        if (tasksList.isNotEmpty) {
          emit(ToDoListLoading());
          var currentTask =
              tasksList.firstWhere((task) => task.id == event.taskId);
          var currentTaskIndex =
              tasksList.indexWhere((task) => task.id == event.taskId);
          var currentTaskStatus = currentTask.completed;
          var changedStatusTask =
              currentTask.copyWith(completed: !currentTaskStatus);
          tasksList.replaceRange(
              currentTaskIndex, currentTaskIndex + 1, [changedStatusTask]);

          localDataSource
              .setTasksToCache(tasksList)
              .then((_) => emit(ToDoListLoaded(tasksList: tasksList)));
        }
      },
    );

    on<FilteringTaskList>((event, emit) {
      List<Task> tasksList = [];
      var currentState = state;

      List<Task> filterByStatus(List<Task> tasksList, bool status) {
        List<Task> filteredTasksList = [];
        filteredTasksList =
            tasksList.where((task) => task.completed == status).toList();
        return filteredTasksList;
      }

      List<Task> filterByCategory(List<Task> tasksList, String category) {
        List<Task> filteredTasksList = [];
        filteredTasksList =
            tasksList.where((task) => task.category == category).toList();
        return filteredTasksList;
      }

      if (currentState is ToDoListLoaded) {
        tasksList = currentState.tasksList;
// Filtering by Status
        (event.filteringByStatusComplete &&
                !event.filteringByStatusNotComplete &&
                event.categoryFilter == 'All')
            ? tasksList = filterByStatus(tasksList, true)
            : (!event.filteringByStatusComplete &&
                    event.filteringByStatusNotComplete &&
                    event.categoryFilter == 'All')
                ? tasksList = filterByStatus(tasksList, false)
// Filtering by Category
                : (!event.filteringByStatusComplete &&
                        !event.filteringByStatusNotComplete &&
                        event.categoryFilter != 'All')
                    ? tasksList =
                        filterByCategory(tasksList, event.categoryFilter)
// Filtering by Status & Category
                    : (event.filteringByStatusComplete &&
                            !event.filteringByStatusNotComplete &&
                            event.categoryFilter != 'All')
                        ? tasksList = filterByCategory(
                            filterByStatus(tasksList, true),
                            event.categoryFilter)
                        : (!event.filteringByStatusComplete &&
                                event.filteringByStatusNotComplete &&
                                event.categoryFilter != 'All')
                            ? tasksList = filterByCategory(
                                filterByStatus(tasksList, false),
                                event.categoryFilter)
                            : tasksList = tasksList;
      }
      emit(ToDoListFiltering(
        tasksList: tasksList,
        filteringByStatusComplete: event.filteringByStatusComplete,
        filteringByStatusNotComplete: event.filteringByStatusNotComplete,
        categoryFilter: event.categoryFilter,
      ));
    });
  }
}
