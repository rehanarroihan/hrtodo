import 'package:flutter/material.dart';
import 'package:hrtodo/ui/widgets/base/button.dart';
import 'package:hrtodo/ui/widgets/base/input.dart';
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _taskNameInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Button(
          onPressed: () => showCreateTaskDialog(),
          label: 'Create New Task',
        ),
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
                      keyboardType: TextInputType.visiblePassword,
                      onClick: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (pickedDate != null) {
                          final DateTime fullResult = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedDate.hour,
                            pickedDate.minute,
                          );

                          _dateInput.text = DateFormat('dd MMMM yyyy').format(fullResult);
                          setState(() {});
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
