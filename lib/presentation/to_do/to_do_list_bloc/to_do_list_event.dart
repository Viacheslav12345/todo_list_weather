part of 'to_do_list_bloc.dart';

@immutable
sealed class ToDoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AddTaskToList extends ToDoListEvent {
  final Task task;

  AddTaskToList({required this.task});
  @override
  List<Object?> get props => [task];
}

final class GetTaskList extends ToDoListEvent {}

final class RemoveTaskFromList extends ToDoListEvent {
  final Task task;

  RemoveTaskFromList({required this.task});
  @override
  List<Object?> get props => [task];
}

final class ChangeStatusTaskInList extends ToDoListEvent {
  final int taskId;

  ChangeStatusTaskInList({required this.taskId});
  @override
  List<Object?> get props => [taskId];
}

final class FilteringTaskList extends ToDoListEvent {
  final bool filteringByStatusComplete;
  final bool filteringByStatusNotComplete;
  final String categoryFilter;
  FilteringTaskList({
    required this.filteringByStatusComplete,
    required this.filteringByStatusNotComplete,
    required this.categoryFilter,
  });
  @override
  List<Object?> get props =>
      [filteringByStatusComplete, filteringByStatusNotComplete, categoryFilter];
}
