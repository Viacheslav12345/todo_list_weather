import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_weather/data/models/task.dart';

abstract class LocalStorageService {
  List<Task> getTasksFromCache();
  Future<void> setTasksToCache(List<Task> tasks);
}

const CACHED_TASKS_LIST = 'CACHED_TASKS_LIST';

class LocalStorageServiceImpl implements LocalStorageService {
  SharedPreferences sharedPreferences;

  LocalStorageServiceImpl({required this.sharedPreferences});

  @override
  List<Task> getTasksFromCache() {
    var tasksStringList =
        sharedPreferences.getStringList(CACHED_TASKS_LIST) ?? [];
    log('Tasks recieved from Cache: ${tasksStringList.length}');
    if (tasksStringList.isNotEmpty) {
      return tasksStringList.map((task) => Task.fromJson(task)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> setTasksToCache(List<Task> tasks) {
    final List<String> tasksList = tasks.map((task) => task.toJson()).toList();
    sharedPreferences.setStringList(CACHED_TASKS_LIST, tasksList);
    log('Tasks writtеn to Cache: ${tasksList.length}');
    return Future<List<String>>.value(tasksList);
  }
}
