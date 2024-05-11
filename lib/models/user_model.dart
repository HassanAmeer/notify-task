import 'user_tasks.dart';

class UserProfile {
  final String uid;
  final String email;
  final String password;
  final List<UserTask> tasks;
  final String profileImageUrl;
  final int timeStamp;

  UserProfile(
      {required this.uid,
      required this.email,
      required this.password,
      required this.tasks,
      required this.profileImageUrl,
      required this.timeStamp});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    List<UserTask> parsedTasks = List<UserTask>.from(
      json['tasks'].map((task) => UserTask.fromJson(task)),
    );

    return UserProfile(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      tasks: parsedTasks,
      profileImageUrl: json['profile'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'profile': profileImageUrl,
      'timeStamp': timeStamp,
    };
  }
}
