class DayTask {
  String title;
  String category;
  int chunkTime;
  bool isComplete;
  DateTime taskDate;

  DayTask({
    required this.title,
    required this.category,
    required this.chunkTime,
    this.isComplete = false,
    required this.taskDate,
  });

  void toggleComplete() {
    isComplete = !isComplete;
  }
}