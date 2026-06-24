import 'package:flutter/material.dart';
import '../models/day_term_task.dart';
import '../models/task_items_menu.dart';

class DayTermTab extends StatelessWidget{
  final List<DayTask> tasks;
  final VoidCallback onAddTask; //Adds a task that home.dart calls and passes no arguments
  final void Function(DayTask task) onEditTask;
  final void Function(DayTask task) onDeleteTask;
  final void Function(DayTask task) onCompleteTask;
  final DateTime selectedDate;
  final VoidCallback onPreviousDay;
  final VoidCallback onNextDay;

  const DayTermTab({
    super.key,
    required this.tasks,
    required this.onAddTask,
    required this.onEditTask,
    required this.onDeleteTask,
    required this.onCompleteTask,
    required this.onNextDay,
    required this.onPreviousDay,
    required this.selectedDate
  });  

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.outlined(
                onPressed: onPreviousDay,
                icon: Icon(Icons.arrow_left)
              ),
              Text(
                '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                style: TextStyle(
                  fontSize: 24,
                ),  
              ),
              IconButton.outlined(
                onPressed: onNextDay,
                icon: Icon(Icons.arrow_right)
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
            
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        '${task.title} | ${task.category} | ${task.chunkTime} min',
                        style: TextStyle(
                          decoration: task.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                      trailing: PopupMenuButton<TaskItemsMenu>(
                        icon: Icon(Icons.more_vert),
                        onSelected: (TaskItemsMenu action) {
                          if (action == TaskItemsMenu.delete) {
                            onDeleteTask(task);
                          }
                          else if (action == TaskItemsMenu.edit) {
                            onEditTask(task);                            
                          }
                          else if (action == TaskItemsMenu.complete) {
                              onCompleteTask(task);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: TaskItemsMenu.edit,
                              child: Text('Edit Task'),
                            ),
                            const PopupMenuItem(
                              value: TaskItemsMenu.delete,
                              child: Text('Delete Task')
                            ),
                            const PopupMenuItem(
                              value: TaskItemsMenu.complete,
                              child: Text('Mark Task As Complete')
                              )
                          ];
                        }
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTask,
        tooltip: 'Add a task for today',
        child: Icon(Icons.add),
      ),
    );
  }
}