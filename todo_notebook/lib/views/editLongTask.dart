import 'package:flutter/material.dart';
import '../models/long_term_task.dart';

class EditLongTaskPage extends StatefulWidget {
  final LongTermTask task;
  const EditLongTaskPage({super.key, required this.task});

  @override
  State<EditLongTaskPage> createState() => _EditLongTaskPageState();
}

class _EditLongTaskPageState extends State<EditLongTaskPage> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    titleController.text = widget.task.title;
    categoryController.text = widget.task.category;
    selectedDate = widget.task.dueDate;    
  }


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
      initialDate: selectedDate,
      firstDate: DateTime.now(), //maybe change to selectedDate?
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
    final editedDueDate = selectedDate;

    if (title.isEmpty || category.isEmpty || editedDueDate == null) {
      return;
    }

    final editedTask = LongTermTask(
      title: title,
      category: category,
      dueDate: selectedDate!,
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
        title: const Text('Edit Long Term Task'),
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
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}