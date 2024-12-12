part of 'task_bloc.dart';

abstract class TaskEvent {}

final class GetTasksEvent extends TaskEvent {}

final class AddTaskEvent extends TaskEvent {
  final Map<String, String> taskData;

  AddTaskEvent({required this.taskData});
}
