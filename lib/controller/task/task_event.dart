part of 'task_bloc.dart';

abstract class TaskEvent {}

final class GetTasksEvent extends TaskEvent {}

final class AddTaskEvent extends TaskEvent {
  final Map<String, String> taskData;

  AddTaskEvent({required this.taskData});
}

final class DestroyTask extends TaskEvent {
  final String id;
  BuildContext context;
  DestroyTask({required this.id, required this.context});
}

final class UpdateTask extends TaskEvent {
  final Map<String, String> updatedData;

  UpdateTask({required this.updatedData});
}
