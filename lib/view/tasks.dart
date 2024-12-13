import 'package:cloudocz/controller/task/task_bloc.dart';
import 'package:cloudocz/model/task_model.dart';
import 'package:cloudocz/view/add_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    context.read<TaskBloc>().add(GetTasksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FeedbackScreen()));
              },
              child: Icon(Icons.add, size: 34),
            ),
          )
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTaskSuccessState) {
            if (state.userTasks.data.isEmpty) {
              return const Center(
                child: Text("You haven't any activity"),
              );
            }
            return ListView.builder(
              itemCount: state.userTasks.data.length,
              itemBuilder: (context, index) {
                Task task = state.userTasks.data[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          task.id.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            task.status,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color: task.status == "incomplete"
                                        ? Colors.red
                                        : Colors.green),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text("${task.percentage.toString()} % "),
                          Expanded(
                            child: Text(
                              task.description,
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                            // Perform edit action
                          } else if (value == 'delete') {
                            context.read<TaskBloc>().add(DestroyTask(
                                id: task.id.toString(), context: context));
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        itemBuilder: (context) {
                          return const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: Colors.blue),
                                  SizedBox(width: 10),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 10),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ];
                        },
                        icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text('No Data Found');
          }
        },
      ),
    );
  }
}
