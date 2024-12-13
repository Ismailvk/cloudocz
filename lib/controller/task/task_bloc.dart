import 'dart:async';
import 'package:cloudocz/model/task_model.dart';
import 'package:cloudocz/repositories/task_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<GetTasksEvent>(getTasksEvent);
    on<AddTaskEvent>(addTaskData);
    on<DestroyTask>(destroyTask);
  }

  FutureOr<void> getTasksEvent(
      GetTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final data = await TaskRepo().getTasks();
      data.fold((error) {
        TaskErrorState(message: error.message.toString());
      }, (response) {
        UserTasks userTasks = UserTasks.fromJson(response);
        emit(GetTaskSuccessState(userTasks: userTasks));
      });
    } catch (e) {
      emit(TaskErrorState(message: e.toString()));
    }
  }

  FutureOr<void> addTaskData(
      AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final data = await TaskRepo().addTask(event.taskData);
      data.fold((error) {
        emit(TaskErrorState(message: error.message.toString()));
      }, (response) {
        emit(AddTaskSuccessState());
      });
    } catch (e) {
      emit(TaskErrorState(message: e.toString()));
    }
  }

  FutureOr<void> destroyTask(DestroyTask event, Emitter<TaskState> emit) async {
    final data = await TaskRepo().destroyTask(event.id);
    try {
      data.fold((error) {
        TaskErrorState(message: error.message.toString());
      }, (response) {
        event.context.read<TaskBloc>().add(GetTasksEvent());
      });
    } catch (e) {
      TaskErrorState(message: e.toString());
    }
  }
}
