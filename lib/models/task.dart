

class Task {
  String? id;
  String name;
  DateTime date;
  bool checked;

  Task({
    this.id,
    required this.name,
    required this.date,
    required this.checked
  });
}