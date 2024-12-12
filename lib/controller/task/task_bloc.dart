import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudocz/model/task_model.dart';
import 'package:cloudocz/repositories/task_repo.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<GetTasksEvent>(getTasksEvent);
    on<AddTaskEvent>(addTaskData);
  }

  FutureOr<void> getTasksEvent(
      GetTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final data = await TaskRepo().getTasks();
      data.fold((error) {
        TaskErrorState(message: error.message.toString());
      }, (response) {
        UserTasks usertasks = UserTasks.fromJson(response);
        emit(GetTaskSuccessState(userTasks: usertasks));
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
}
