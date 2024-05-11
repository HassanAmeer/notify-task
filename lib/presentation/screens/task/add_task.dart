import 'package:abshartodo/helpers/time_format.dart';
import 'package:abshartodo/models/user_tasks.dart';
import 'package:abshartodo/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:abshartodo/presentation/widgets/error_box.dart';
import 'package:abshartodo/services/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contants/apptheme.dart';
import '../../widgets/delete_alert.dart';

class AddTaskPage extends StatefulWidget {
  final List<UserTask> TaskList;

  const AddTaskPage({Key? key, required this.TaskList}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController _taskName = TextEditingController();
  TextEditingController _description = TextEditingController();

  String _category = "work";
  DateTime _dateTime = DateTime.now(); // Changed to DateTime for date and time
  bool _status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 4),
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(1.0),
              shape: MaterialStateProperty.all(BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
              backgroundColor: MaterialStateProperty.all(
                  MaterialColors.deepOrange.shade100)),
          onPressed: () async {
            List<UserTask> TaskList = [];
            TaskList = widget.TaskList;
            TaskList.add(UserTask(
                taskName: _taskName.text,
                taskDesc: _description.text,
                catg: _category,
                dateTime: _dateTime.toString(),
                miliSeconds: _dateTime
                    .difference(DateTime.now())
                    .inMilliseconds
                    .toString(),
                status: _status == true ? "done" : "pending"));
            context
                .read<AuthBloc>()
                .add(TaskUpdateEvent(context: context, userTaskList: TaskList));
            await showNotification(
                title: _taskName.text,
                body: _description.text,
                executionTimeMilliseconds:
                    _dateTime.difference(DateTime.now()).inMilliseconds);
          },
          child: const Text('Add Task'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _taskName,
              decoration: const InputDecoration(
                labelText: 'Task Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _description,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
                value: _category,
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                items: <String>['work', 'Personal', 'Shopping']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                decoration: const InputDecoration(labelText: 'Category')),
            const SizedBox(height: 30.0),
            Stack(children: [
              const Divider(color: Colors.black, thickness: 1),
              Center(
                  child: Container(
                      color: Colors.grey.shade50,
                      child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(' Others ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 2)))))
            ]),
            ListTile(
              tileColor: Colors.blueGrey.shade50,
              title: const Text('Date & Time'),
              leading: const Icon(Icons.calendar_today), // Leading icon
              trailing: Text(
                  '${_dateTime.year}-${_dateTime.month}-${_dateTime.day} ${Helpers.formatTime(_dateTime)}' // Display both date and time with AM/PM
                  ),
              onTap: () async {
                final DateTime? pickedDateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2200),
                );
                if (pickedDateTime != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_dateTime));
                  if (pickedTime != null) {
                    setState(() {
                      _dateTime = DateTime(
                          pickedDateTime.year,
                          pickedDateTime.month,
                          pickedDateTime.day,
                          pickedTime.hour,
                          pickedTime.minute);
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 4.0),
            ListTile(
              tileColor: Colors.blueGrey.shade50,
              leading:
                  const Icon(Icons.check_circle), // Leading icon for status
              title: const Text('Status'),
              trailing: Checkbox(
                value: _status,
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthError) {
                  return ErrorBox(errorMessage: state.errorMsg);
                } else {
                  return const Text("");
                }
              },
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
