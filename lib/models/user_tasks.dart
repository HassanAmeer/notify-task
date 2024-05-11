class UserTask {
  final String taskName;
  final String taskDesc;
  final String catg;
  final String dateTime;
  final String miliSeconds;
  String status;

  UserTask({
    required this.taskName,
    required this.taskDesc,
    required this.catg,
    required this.dateTime,
    required this.miliSeconds,
    required this.status,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      taskName: json['taskName'],
      taskDesc: json['taskDesc'],
      catg: json['catg'],
      dateTime: json['dateTime'],
      miliSeconds: json['miliSeconds'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskDesc': taskDesc,
      'catg': catg,
      'dateTime': dateTime,
      'miliSeconds': miliSeconds,
      'status': status,
    };
  }
}
