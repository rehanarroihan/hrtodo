import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrtodo/bloc/task/task_cubit.dart';
import 'package:hrtodo/models/task.dart';
import 'package:hrtodo/ui/widgets/base/button.dart';
import 'package:hrtodo/ui/widgets/base/input.dart';
import 'package:hrtodo/ui/widgets/modules/empty_state.dart';
import 'package:hrtodo/ui/widgets/modules/task_item.dart';
import 'package:hrtodo/utils/app_colors.dart';
import 'package:hrtodo/utils/show_flutter_toast.dart';
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late TaskCubit _taskCubit;

  final TextEditingController _taskNameInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  DateTime? _pickedDate;

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
        if (state is CreateTaskSuccessful) {
          showFlutterToast("Task created");
          Navigator.pop(context);
        }
      },
      child: BlocBuilder(
        bloc: _taskCubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: AppBar(
              title: const Text('Task List'),
            ),
            body: _taskCubit.taskList.isEmpty ? Center(
              child: EmptyState(
                imagePath: 'assets/illustrations/box_empty_state.png',
                title: AppLocalizations.of(context).noTaskCreated,
                description: AppLocalizations.of(context).noTaskCreatedDescription,
              )
            ) :
            ListView.builder(
              itemCount: _taskCubit.taskList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TaskItem(
                    task: _taskCubit.taskList[index],
                    disabled: false,
                    onChanged: (bool? checked) {

                    }
                  ),
                );
              },
            ),
            bottomNavigationBar: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Button(
                onPressed: () => showCreateTaskDialog(),
                label: 'Create New Task',
              ),
            ),
          );
        }
      ),
    );
  }

  void showCreateTaskDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (BuildContext _) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFdfdfdf),
                      width: 1,
                    ),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create new task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.close)
                    )
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Input(
                      controller: _taskNameInput,
                      prefixIcon: Icons.list,
                      label: 'Task name',
                      hint: 'Input task name',
                    ),

                    const SizedBox(height: 12),

                    Input(
                      controller: _dateInput,
                      label: 'Date',
                      hint: 'Pick date',
                      prefixIcon: Icons.calendar_month_rounded,
                      onClick: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 0)),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          final DateTime fullResult = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedDate.hour,
                            pickedDate.minute,
                          );

                          setState(() {
                            _dateInput.text = DateFormat('dd MMMM yyyy').format(fullResult);
                            _pickedDate = fullResult;
                          });
                        } else {
                          return;
                        }
                      },
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: Button(
                        onPressed: () {
                          _taskCubit.createTask(Task(
                            name: _taskNameInput.text,
                            date: _pickedDate!,
                            checked: false
                          ));
                        },
                        label: 'Create Task',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
