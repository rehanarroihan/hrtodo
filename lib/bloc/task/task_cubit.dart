import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hrtodo/models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  List<Task> taskList = [];

  void createTask(Task newTask) {
    emit(CreateTaskInit());

    try {
      taskList.add(newTask);

      emit(CreateTaskSuccessful());
    } catch (e) {
      emit(CreateTaskFailed());
    }
  }
}
