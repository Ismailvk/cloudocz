import 'package:cloudocz/controller/task/task_bloc.dart';
import 'package:cloudocz/model/task_model.dart';
import 'package:cloudocz/utils/validation.dart';
import 'package:cloudocz/view/home.dart';
import 'package:cloudocz/widgets/button.dart';
import 'package:cloudocz/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? taskData;
  const AddTaskScreen({super.key, this.taskData});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.taskData != null) {
      isEdit = true;
      final title = widget.taskData!.name;
      final description = widget.taskData!.description;
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            MyTextField(
              validator: (value) => Validation.isEmpty(value, 'Title'),
              controller: titleController,
              hintText: "Enter Title",
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter Description',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Select Date',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                labelText: 'Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 20.0),
            BlocConsumer<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is AddTaskSuccessState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is TaskLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                bool isLoading = state is TaskLoadingState;
                return MyLoadingButton(
                  isLoading: isLoading,
                  title: isEdit ? 'Update' : 'Submit',
                  onTap: () => submitPost(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void submitPost() {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String deadline = dateController.text.trim();

    if (title.isEmpty || description.isEmpty || deadline.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please fill all fields and select an image'),
      ));
      return;
    } else {
      Map<String, String> taskData = {
        "name": title,
        "description": description,
        "deadline": deadline,
      };
      isEdit
          ? context.read<TaskBloc>().add(UpdateTask(
              updatedData: taskData, id: widget.taskData!.id.toString()))
          : context.read<TaskBloc>().add(AddTaskEvent(taskData: taskData));
    }
  }
}
