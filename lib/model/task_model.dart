class UserTasks {
  final int totalTasks;
  final int pendingTasks;
  final List<Task> data;

  UserTasks({
    required this.totalTasks,
    required this.pendingTasks,
    required this.data,
  });

  factory UserTasks.fromJson(Map<String, dynamic> json) {
    return UserTasks(
      totalTasks: json['total_tasks'] ?? 0,
      pendingTasks: json['pending_tasks'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((taskJson) => Task.fromJson(taskJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_tasks': totalTasks,
      'pending_tasks': pendingTasks,
      'data': data.map((task) => task.toJson()).toList(),
    };
  }
}

class Task {
  final int id;
  final String name;
  final String description;
  final int percentage;
  final String status;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.percentage,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      percentage: json['percentage'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'percentage': percentage,
      'status': status,
    };
  }
}
