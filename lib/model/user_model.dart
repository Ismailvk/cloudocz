class UserProfile {
  final String token;
  final String image;
  final String name;
  final String position;
  final int noOfTask;
  final double percentage;

  UserProfile({
    required this.token,
    required this.image,
    required this.name,
    required this.position,
    required this.noOfTask,
    required this.percentage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      token: json['token'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      noOfTask: json['no_of_task'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'image': image,
      'name': name,
      'position': position,
      'no_of_task': noOfTask,
      'percentage': percentage,
    };
  }
}
