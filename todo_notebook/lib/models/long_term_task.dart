class LongTermTask {
  String title;
  String category;
  DateTime dueDate;
  bool isComplete;

  LongTermTask({
    required this.title,
    required this.category,
    required this.dueDate,
    this.isComplete = false
  });

}