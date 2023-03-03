import 'package:flutter/material.dart';
import 'package:hrtodo/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final bool disabled;
  final ValueChanged<bool?> onChanged;

  const TaskItem({
    super.key,
    required this.task,
    required this.disabled,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ]
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Checkbox(
            value: task.checked,
            onChanged: onChanged
          ),
          Text(
            task.name
          )
        ],
      ),
    );
  }
}
