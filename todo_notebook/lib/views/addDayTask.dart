import 'package:flutter/material.dart';
import '../models/day_term_task.dart';

class AddDayTaskPage extends StatefulWidget {
  const AddDayTaskPage({super.key});

  @override
  State<AddDayTaskPage> createState() => _AddDayTaskPageState();
}

class _AddDayTaskPageState extends State<AddDayTaskPage> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final chunkTimeController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    chunkTimeController.dispose();
    super.dispose();
  }

  void saveTask() {
    final title = titleController.text.trim();
    final category = categoryController.text.trim();
    final chunkTime = int.tryParse(chunkTimeController.text.trim());

    if (title.isEmpty || category.isEmpty || chunkTime == null) {
      return;
    }

    final newTask = DayTask(
      title: title,
      category: category,
      chunkTime: chunkTime,
    );

    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Day Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: chunkTimeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Chunk Time',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveTask,
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}