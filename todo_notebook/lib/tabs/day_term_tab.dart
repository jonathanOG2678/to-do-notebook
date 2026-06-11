import 'package:flutter/material.dart';
import '../models/day_term_task.dart';
import '../models/task_items_menu.dart';

class DayTermTab extends StatelessWidget{
  final List<DayTask> tasks;
  final VoidCallback onAddTask; //Adds a task that home.dart calls and passes no arguments
  final void Function(int index) onEditTask;
  final void Function(int index) onDeleteTask;
  final void Function(int index) onCompleteTask;

  const DayTermTab({
    super.key,
    required this.tasks,
    required this.onAddTask,
    required this.onEditTask,
    required this.onDeleteTask,
    required this.onCompleteTask,
  });  

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
                      onDeleteTask(index);
                    }
                    else if (action == TaskItemsMenu.edit) {
                      onEditTask(index);                            
                    }
                    else if (action == TaskItemsMenu.complete) {
                        onCompleteTask(index);
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
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTask,
        tooltip: 'Add a task for today',
        child: Icon(Icons.add),
      ),
    );
  }
}