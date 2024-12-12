import 'package:cloudocz/controller/task/task_bloc.dart';
import 'package:cloudocz/main.dart';
import 'package:cloudocz/utils/validation.dart';
import 'package:cloudocz/view/home.dart';
import 'package:cloudocz/widgets/button.dart';
import 'package:cloudocz/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
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
              controller: _descriptionController,
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
              controller: _dateController,
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                }
              },
              builder: (context, state) {
                if (state is TaskLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ButtonWidget(
                  title: 'Submit Post',
                  onPress: () => submitPost(),
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
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void submitPost() {
    String title = titleController.text.trim();
    String description = _descriptionController.text.trim();
    String deadline = _dateController.text.trim();

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
      context.read<TaskBloc>().add(AddTaskEvent(taskData: taskData));
    }
  }
}
