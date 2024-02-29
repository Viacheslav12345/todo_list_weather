part of 'to_do_list_bloc.dart';

@immutable
sealed class ToDoListState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ToDoListInitial extends ToDoListState {}

final class ToDoListLoading extends ToDoListState {}

final class ToDoListLoaded extends ToDoListState {
  final List<Task> tasksList;

  ToDoListLoaded({required this.tasksList});
  @override
  List<Object?> get props => [tasksList];
}

final class ToDoListFiltering extends ToDoListState {
  final List<Task> tasksList;
  final bool filteringByStatusComplete;
  final bool filteringByStatusNotComplete;
  final String categoryFilter;

  ToDoListFiltering({
    required this.tasksList,
    required this.filteringByStatusComplete,
    required this.filteringByStatusNotComplete,
    required this.categoryFilter,
  });
  @override
  List<Object?> get props => [
        tasksList,
        filteringByStatusComplete,
        filteringByStatusNotComplete,
        categoryFilter
      ];
}
