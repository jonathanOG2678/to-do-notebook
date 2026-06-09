class DayTask {
  String title;
  String category;
  int chunkTime;
  bool isComplete;

  DayTask({
    required this.title,
    required this.category,
    required this.chunkTime,
    this.isComplete = false
  });
}