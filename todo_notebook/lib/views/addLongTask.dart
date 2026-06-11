/*
USE showDatePicker Widget for data
*/
import 'package:flutter/material.dart';
import '../models/long_term_task.dart';


class AddLongTaskPage extends StatefulWidget {
  const AddLongTaskPage({super.key});

  @override
  State<AddLongTaskPage> createState() => _AddLongTaskPageState();
}

class _AddLongTaskPageState extends State<AddLongTaskPage> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  //Function skeleton from showDatePicker Widget Flutter Documentation
  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null){
    setState(() {
      selectedDate = pickedDate;
    });
    }
  }

  void saveTask() {
    final title = titleController.text.trim();
    final category = categoryController.text.trim();
    final dueDate = selectedDate;
    if (title.isEmpty || category.isEmpty || dueDate == null) {
      return;
    }

    final newTask = LongTermTask(
      title: title,
      category: category,
      dueDate: dueDate,
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
            ElevatedButton(
              onPressed: selectDate,
              child: Text(
                selectedDate == null
                ? 'Select Due Date' 
                : 'Due ${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}',
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