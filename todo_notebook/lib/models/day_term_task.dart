class DayTask {
  int? id;
  String title;
  String category;
  int chunkTime;
  bool isComplete;
  DateTime taskDate;

  DayTask({
    this.id,
    required this.title,
    required this.category,
    required this.chunkTime,
    this.isComplete = false,
    required this.taskDate,
  });

  void toggleComplete() {
    isComplete = !isComplete;
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'chunk_time': chunkTime,
      'is_complete': isComplete? 1 : 0,
      'task_date': dateKey(taskDate),
    };
  }

  factory DayTask.fromMap(Map<String, Object?> map) {
    return DayTask(
      id: map['id'] as int?,
      title: map['title'] as String,
      category: map['category'] as String,
      chunkTime: map['chunk_time'] as int,
      isComplete: map['is_complete'] == 1,
      taskDate: DateTime.parse(map['task_date'] as String),
    );
  }

  static String dateKey(DateTime date) {
    final year = date.year.toString().padLeft(4, '0'); //fixes the length for uniform dates
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0'); 

    return '$year-$month-$day';
  }
}