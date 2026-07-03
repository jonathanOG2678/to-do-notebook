class LongTermTask {
  int? id;
  String title;
  String category;
  DateTime dueDate;
  bool isComplete;

  LongTermTask({
    this.id,
    required this.title,
    required this.category,
    required this.dueDate,
    this.isComplete = false
  });


  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'is_complete': isComplete? 1 : 0,
      'due_date': dateKey(dueDate),
    };
  }


  static String dateKey(DateTime date) {
    final year = date.year.toString().padLeft(4, '0'); //fixes the length for uniform dates
    final month = date.month.toString().padLeft(2, '0');
    final day = date.month.toString().padLeft(2, '0'); 

    return '$year-$month-$day';
  }

}