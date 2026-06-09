import 'package:flutter/material.dart';
import 'views/dayTermTab.dart';
import 'views/longTermTab.dart';
import 'views/addDayTask.dart';
import 'views/addLogTask.dart';

enum TaskItemsMenu {
  edit,
  delete,
  complete
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            Scaffold(
              body: ListView.builder(
                itemCount: dayTermTasks.length,
                itemBuilder: (context, index) {
                  final task = dayTermTasks[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text('${task.title} | ${task.category} | ${task.chunkTime} min'),                   
                        trailing: PopupMenuButton<TaskItemsMenu>(
                          icon: Icon(Icons.more_vert),
                          onSelected: (TaskItemsMenu action) {
                            if (action == TaskItemsMenu.delete) {
                              dayTermTasks.removeAt(index);
                              setState(() {
                                
                              });
                            }
                            else if (action == TaskItemsMenu.edit) {
                              //
                            }
                            else if (action == TaskItemsMenu.complete) {
                              setState(() {
                                task.isComplete = true;
                              });
                            }

                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: TaskItemsMenu.edit,
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: TaskItemsMenu.delete,
                                child: Text('Delete')
                              ),
                              const PopupMenuItem(
                                value: TaskItemsMenu.complete,
                                child: Text('Mark Complete')
                                )
                            ];
                          }
                        ),
                      ),
                    ),
                  );
                }
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: addDayTask,
                tooltip: 'Add a task for today',
                child: Icon(Icons.add),
              ),
            ),

            Scaffold(
              body: ListView.builder(
                itemCount: longTermTasks.length,
                itemBuilder: (context, index) {
                  final task = longTermTasks[index];

                  return ListTile(
                    title: Text('${task.title} | ${task.category} | here'),                    
                  );
                }
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                tooltip: 'Add a long term task',
                child: Icon(Icons.add),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

