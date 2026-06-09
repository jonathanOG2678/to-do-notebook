/*
USE showDatePicker Widget for data
*/
import 'package:flutter/material.dart';

class AddLongTaskPage extends StatefulWidget {
  const AddLongTaskPage({super.key});

  @override
  State<AddLongTaskPage> createState() => _AddLongTaskPageState();
}

class _AddLongTaskPageState extends State<AddLongTaskPage> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void saveTask() {
    final title = titleController.text.trim();
    final category = categoryController.text.trim();

    if (title.isEmpty || category.isEmpty == null) {
      return;
    }

    final newTask = DayTask(
      title: title,
      category: category,
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