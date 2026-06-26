import 'dart:async';
import 'package:path/path.dart' as p; //conflicted with BuildContext
import 'package:sqflite/sqflite.dart';

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
    required this.taskDate
  });

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

  //Add fromMap

  /*
  - A Database instance
  - A method to open the database
  - A method to insert a Counter into the table
  - A method to get a Counter from the table by id
  - A method to delete an entry from the table by id
  - A method to update a Counter entry
  - A method to close the database
  - A method to create a Counter and write the data to the tableCounter
  - A method to read data into the file
   */

  static String dateKey(DateTime date) {
    final year = date.year.toString().padLeft(4, '0'); //fixes the length for uniform dates
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0'); 

    return '$year-$month-$day';
  }
}


class LongTask {
  int? id;
  String title;
  String category;
  bool isComplete;
  DateTime dueDate;

  LongTask({
    this.id,
    required this.title,
    required this.category,
    this.isComplete = false,
    required this.dueDate,
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