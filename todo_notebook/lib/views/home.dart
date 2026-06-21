import 'package:flutter/material.dart';
import '../models/day_term_task.dart';
import '../models/long_term_task.dart';
import '../tabs/day_term_tab.dart';
import '../tabs/long_term_tab.dart';
import '../views/addDayTask.dart';
import '../views/editDayTask.dart';
import '../views/addLongTask.dart';
import '../views/editLongTask.dart';

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
  final List<DayTask> dayTermTasks = [];
  final List<LongTermTask> longTermTasks = [];
  

  Future<void> addDayTask() async {
    final DayTask? newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddDayTaskPage(),
      ),
    );

    if (newTask != null) {
      setState(() {
        dayTermTasks.add(newTask);
      });
    }
  }

  Future<void> editDayTask(int index) async {
    final DayTask selectedTask = dayTermTasks[index];

    final DayTask? editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDayTaskPage(
          task: selectedTask,
        )      
      )
    );

    if (editedTask!= null) {
      setState(() {
        dayTermTasks[index] = editedTask;
      });
    }
  }

  Future<void> deleteDayTask(int index) async{
    setState(() {
      dayTermTasks.removeAt(index);
    });
    const deleteSnackbar = SnackBar(content: Text('Task deleted'));
    ScaffoldMessenger.of(context).showSnackBar(deleteSnackbar); 
  }

  Future<void> completeDayTask(int index) async {
    setState(() {
      dayTermTasks[index].isComplete = true;
    });
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
    const deleteSnackbar = SnackBar(content: Text('Task deleted'));
    ScaffoldMessenger.of(context).showSnackBar(deleteSnackbar); 
  }

  Future<void> completeLongTask(int index) async {
    setState(() {
      longTermTasks[index].isComplete = true;
    });
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
        body: TabBarView(
          children: [
            DayTermTab(
              tasks: dayTermTasks, 
              onAddTask: addDayTask,
              onEditTask: editDayTask,
              onDeleteTask: deleteDayTask,
              onCompleteTask: completeDayTask,
            ),
            LongTermTab(
              tasks: longTermTasks,
              onAddTask: addLongTask,
              onEditTask: editLongTask,
              onDeleteTask: deleteLongTask,
              onCompleteTask: completeLongTask,              
            ),
          ]
        ),
      ),
    );
  }
}

