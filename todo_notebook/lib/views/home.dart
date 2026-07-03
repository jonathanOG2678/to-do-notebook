import 'package:flutter/material.dart';
import '../models/day_term_task.dart';
import '../models/long_term_task.dart';
import '../tabs/day_term_tab.dart';
import '../tabs/long_term_tab.dart';
import '../views/addDayTask.dart';
import '../views/editDayTask.dart';
import '../views/addLongTask.dart';
import '../views/editLongTask.dart';
import '../data/sqlite_database.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do Notebook',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'To-Do Notebook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DayTask> dayTermTasks = [];
  final List<LongTermTask> longTermTasks = [];
  DateTime selectedDate = DateTime.now();
  //final selectedDateTasks = [];
  final _storage = SqliteDatabase();
  bool databaseReady = false;
 
  @override
  void initState() {
    super.initState();

    try {
      _storage.open('day_tasks_v3.db').then((_) async {
        await loadDayTasksForSelectedDate();
      
        setState(() {
            databaseReady = true;
          });      
      }); 
    } catch (e) {
      print('Database initialization error: $e');

      setState(() {
        databaseReady = true;    });
    }
  }

  @override
  void dispose() {
    _storage.close();
    super.dispose();
  }

  Future<void> loadDayTasksForSelectedDate() async {
      final tasks = await _storage.getDayTasksForDay(selectedDate);
      
      print('Loaded ${tasks.length} tasks for ${DayTask.dateKey(selectedDate)}');
      setState(() {
        dayTermTasks = tasks;
      });
  }

  Future<void> goToToday() async{
    setState(() {
      selectedDate = DateTime.now();
    });
    
    await loadDayTasksForSelectedDate();
    const completeSnackbar = SnackBar(content: Text('Moved to today'));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(completeSnackbar); 
  }

  Future<void> goToPreviousDay() async {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });

    await loadDayTasksForSelectedDate();
  }

  Future<void> goToNextDay() async {
    if (isSameDay(DateTime.now(), selectedDate)) {
      const completeSnackbar = SnackBar(content: Text('Cannot view future'));
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(completeSnackbar); 
      return; //Prevent the user to go to the future
    } 
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });

    await loadDayTasksForSelectedDate();

  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // List<DayTask> get selectedDateTaskList {
  //   return dayTermTasks.where((task) {
  //     return isSameDay(task.taskDate, selectedDate);
  //   }).toList();
  // }


  Future<void> addDayTask() async {
    final DayTask? newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddDayTaskPage(),
      ),
    );

    if (newTask != null) {
      await _storage.insertDayTask(newTask);

      setState(() {
        selectedDate = DateTime.now(); //Go back to view neew task added
      });

      await loadDayTasksForSelectedDate();
    }
  }

  Future<void> editDayTask(DayTask task) async {
    final DayTask selectedTask = task;
    final int taskIndex = dayTermTasks.indexOf(task);

    final DayTask? editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDayTaskPage(
          task: selectedTask,
        )      
      )
    );

    if (editedTask!= null && taskIndex != -1) {
      await _storage.updateDayTask(editedTask);

      setState(() {
        dayTermTasks[taskIndex] = editedTask;
      });
    }
  }

  Future<void> deleteDayTask(DayTask task) async{
    await _storage.deleteDayTask(task);
    
    setState(() {
      dayTermTasks.remove(task);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    const deleteSnackbar = SnackBar(content: Text('Task deleted'));
    ScaffoldMessenger.of(context).showSnackBar(deleteSnackbar); 
  }

  Future<void> completeDayTask(DayTask task) async {
    setState(() {
      task.isComplete = true;
    });

    await _storage.updateDayTask(task);

    ScaffoldMessenger.of(context).clearSnackBars();
    const completeSnackbar = SnackBar(content: Text('Task completed!'));
    ScaffoldMessenger.of(context).showSnackBar(completeSnackbar); 
  }
  //--------Long Term-----------//
  Future<void> addLongTask() async {
    final LongTermTask? newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddLongTaskPage(),
      ),
    );

    if (newTask != null) {
      setState(() {
        longTermTasks.add(newTask);
      });
    }
  }

  Future<void> editLongTask(int index) async {
    final LongTermTask selectedTask = longTermTasks[index];

    final LongTermTask? editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditLongTaskPage(
          task: selectedTask,
        )      
      )
    );

    if (editedTask!= null) {
      setState(() {
        longTermTasks[index] = editedTask;
      });
    }
  }

  Future<void> deleteLongTask(int index) async{
    setState(() {
      longTermTasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    const deleteSnackbar = SnackBar(content: Text('Task deleted'));
    ScaffoldMessenger.of(context).showSnackBar(deleteSnackbar); 
  }

  Future<void> completeLongTask(int index) async {
    setState(() {
      longTermTasks[index].isComplete = true;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    const completeSnackbar = SnackBar(content: Text('Task completed!'));
    ScaffoldMessenger.of(context).showSnackBar(completeSnackbar); 
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Day Term'),
              Tab(text: 'Long Term'),
            ],
          ),
        ),
        body: databaseReady
        ? TabBarView(
          children: [
            DayTermTab(
              tasks: dayTermTasks,//selectedDateTaskList,
              onGoToday: goToToday,
              onPreviousDay: goToPreviousDay,
              onNextDay: goToNextDay,
              onAddTask: addDayTask,
              onEditTask: editDayTask,
              onDeleteTask: deleteDayTask,
              onCompleteTask: completeDayTask,
              selectedDate: selectedDate,
            ),
            LongTermTab(
              tasks: longTermTasks,
              onAddTask: addLongTask,
              onEditTask: editLongTask,
              onDeleteTask: deleteLongTask,
              onCompleteTask: completeLongTask,              
            ),
          ]
        )
        : const Center(
          child: CircularProgressIndicator(),
        ), 
      ),
    );
  }
}

