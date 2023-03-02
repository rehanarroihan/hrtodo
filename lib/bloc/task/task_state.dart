part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class CreateTaskInit extends TaskState {}

class CreateTaskSuccessful extends TaskState {}

class CreateTaskFailed extends TaskState {}
