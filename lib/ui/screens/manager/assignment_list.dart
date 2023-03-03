import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hrtodo/bloc/task/task_cubit.dart';
import 'package:hrtodo/models/task.dart';
import 'package:hrtodo/ui/widgets/modules/empty_state.dart';
import 'package:hrtodo/ui/widgets/modules/task_item.dart';
import 'package:hrtodo/utils/app_colors.dart';
import 'package:hrtodo/utils/show_flutter_toast.dart';
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
        if (state is UpdateTaskSuccessful) {
          showFlutterToast('Task updated');
        }
      },
      child: BlocBuilder(
        bloc: _taskCubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: AppBar(
              title: const Text('Assignment List'),
              leading: IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: _taskCubit.taskList.isEmpty ? Center(
              child: EmptyState(
                imagePath: 'assets/illustrations/box_empty_state.png',
                title: AppLocalizations.of(context).noAssignedTask,
                description: AppLocalizations.of(context).noAssignedTaskDescription,
              )
            ) :
            GroupedListView<Task, String>(
              elements: _taskCubit.taskList,
              groupBy: (Task task) => DateFormat('dd MMMM yyyy').format(task.date),
              groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
              itemBuilder: (context, Task task) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: TaskItem(
                  task: task,
                  disabled: false,
                  onChanged: (bool? checked) {
                    task.checked = checked!;
                    _taskCubit.updateTask(task);
                  }
                ),
              ),
              itemComparator: (Task item1, Task item2) => item1.id!.compareTo(item2.id!),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              floatingHeader: true,
            ),
          );
        }
      ),
    );
  }
}
