import 'package:flutter/material.dart';
import '../models/day_term_task.dart';

class EditDayTaskPage extends StatefulWidget {
  final DayTask task;
  const EditDayTaskPage({super.key, required this.task});

  @override
  State<EditDayTaskPage> createState() => _EditDayTaskPageState();
}

class _EditDayTaskPageState extends State<EditDayTaskPage> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final chunkTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.task.title;
    categoryController.text = widget.task.category;
    chunkTimeController.text = widget.task.chunkTime.toString();    
  }


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

    final editedTask = DayTask(
      title: title,
      category: category,
      chunkTime: chunkTime,
      isComplete: widget.task.isComplete,
    );
    
    const editSnackbar = SnackBar(content: Text('Task updated'));
    ScaffoldMessenger.of(context).showSnackBar(editSnackbar); 

    Navigator.pop(context, editedTask);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Day Task'),
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
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}