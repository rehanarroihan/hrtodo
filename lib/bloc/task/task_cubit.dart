import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hrtodo/models/task.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  List<Task> taskList = [];

  void createTask(Task newTask) {
    emit(CreateTaskInit());

    try {
      newTask.id = const Uuid().v1();
      taskList.add(newTask);

      emit(CreateTaskSuccessful());
    } catch (e) {
      emit(CreateTaskFailed());
    }
  }

  void updateTask(Task willUpdateTask) {
    emit(UpdateTaskInit());

    try {
      int willUpdateIndex = taskList.indexWhere((task) => task.id == willUpdateTask.id);
      taskList[willUpdateIndex] = willUpdateTask;

      emit(UpdateTaskSuccessful());
    } catch (e) {
      emit(UpdateTaskFailed());
    }
  }
}
