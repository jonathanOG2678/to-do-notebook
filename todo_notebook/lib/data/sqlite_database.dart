import 'package:path/path.dart' as p; //conflicted with BuildContext
import 'package:sqflite/sqflite.dart';
import '../models/day_term_task.dart';
import '../models/long_term_task.dart';

const String dayTaskTable = 'day_tasks';
const String longTaskTable = 'long_tasks';

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
class SqliteDatabase {
  late Database db;

  //The following function skeleton is courtesy by Professor Shelly Wong
  Future open(String path) async {
    db = await openDatabase(
      p.join(await getDatabasesPath(), path), version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $dayTaskTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            category TEXT NOT NULL,
            chunk_time INTEGER NOT NULL,
            is_complete INTEGER NOT NULL,
            task_date TEXT NOT NULL
          )
          ''');

        // await db.execute('''
        //   CREATE TABLE $longTaskTable (
        //     id INTEGER PRIMARY KEY AUTOINCREMENT,
        //     title TEXT NOT NULL,
        //     category TEXT NOT NULL,
        //     is_complete INTEGER NOT NULL,
        //     due_date TEXT NOT NULL)
        //   ''');          
      }
    );
  }

  Future<DayTask> insertDayTask(DayTask task) async {
    task.id = await db.insert(
      dayTaskTable,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return task;
  }

  Future<List<DayTask>> getDayTasksForDay(DateTime selectedDate) async {
    final maps = await db.query(
      dayTaskTable,
      where: 'task_date = ?',
      whereArgs: [DayTask.dateKey(selectedDate)],
    );

    return maps.map((map) {
      return DayTask.fromMap(map);
    }).toList();
  }

  Future<void> updateDayTask(DayTask task) async {
    await db.update(
      dayTaskTable,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id]  
    );
  }

  Future<void> deleteDayTask(DayTask task) async {
    await db.delete(
      dayTaskTable,
      where: 'id = ?',
      whereArgs: [task.id]
    );
  }

  Future close() async => db.close();

}