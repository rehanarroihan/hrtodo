import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hrtodo/bloc/task/task_cubit.dart';
import 'package:hrtodo/models/task.dart';
import 'package:hrtodo/utils/app_colors.dart';
import 'package:intl/intl.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({super.key});

  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  late TaskCubit _taskCubit;

  @override
  void initState() {
    _taskCubit = BlocProvider.of<TaskCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _taskCubit,
      listener: (contex, state) {

      },
      child: BlocBuilder(
        bloc: _taskCubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: AppBar(
              title: const Text('Assignment List'),
            ),
            body: GroupedListView<Task, String>(
              elements: _taskCubit.taskList,
              groupBy: (Task task) => DateFormat('dd MMMM yyyy').format(task.date),
              groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
              itemBuilder: (context, Task element) => Text(element.name),
              itemComparator: (Task item1, Task item2) => item1.name.compareTo(item2.name), // optional
              useStickyGroupSeparators: true, // optional
              floatingHeader: true, // optional
            ),
          );
        }
      ),
    );
  }
}
