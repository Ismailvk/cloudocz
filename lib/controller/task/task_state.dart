part of 'task_bloc.dart';

abstract class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState({required this.message});
}

final class GetTaskSuccessState extends TaskState {
  final UserTasks userTasks;

  GetTaskSuccessState({required this.userTasks});
}

final class AddTaskSuccessState extends TaskState {}
