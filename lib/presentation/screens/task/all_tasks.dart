import 'package:abshartodo/helpers/time_format.dart';
import 'package:abshartodo/models/user_tasks.dart';
import 'package:abshartodo/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../contants/apptheme.dart';
import '../../widgets/delete_alert.dart';
import 'update_task.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({super.key});

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  TextEditingController filterControler = TextEditingController();
  bool isPendingStatus = true;
  String isPendingStatusValue = "pending";
  bool isFilter = false;
  String filterValue = "";
  List userTasksMarkedByIndex = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(title: const Text("All Tasks"), actions: [
            IconButton(
                onPressed: () {
                  deleteAccountAlert(context, title: "Want to Delete All ?",
                      onTap: () {
                    context.read<AuthBloc>().add(TaskUpdateEvent(
                        context: context, userTaskList: const []));
                    Navigator.pop(context);
                  });
                },
                icon: const Icon(Icons.delete_sweep_outlined))
          ]),
          floatingActionButton: SegmentedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(1.0),
                shape: MaterialStateProperty.all(BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(14))),
                backgroundColor: MaterialStateProperty.all(
                    MaterialColors.deepOrange.shade100)),
            segments: const [
              ButtonSegment(
                  value: "1",
                  label: Text("Pending"),
                  icon: Icon(Icons.history)),
              ButtonSegment(
                  value: "2",
                  label: Text("Finished"),
                  icon: Icon(Icons.checklist)),
            ],
            onSelectionChanged: (selected) {
              if (selected.first == "1") {
                // log("finished $selected");

                if (state is AuthLoaded) {
                  List<UserTask> userTasksList = [...state.userProfile.tasks];

                  for (var i = 0; i < userTasksList.length; i++) {
                    if (userTasksMarkedByIndex.contains(i)) {
                      userTasksList[i].status = "pending";
                    }
                  }
                  context.read<AuthBloc>().add(TaskUpdateEvent(
                      context: context, userTaskList: userTasksList));
                }
              } else if (selected.first == "2") {
                if (state is AuthLoaded) {
                  List<UserTask> userTasksList = [...state.userProfile.tasks];

                  for (var i = 0; i < userTasksList.length; i++) {
                    if (userTasksMarkedByIndex.contains(i)) {
                      userTasksList[i].status = "done";
                    }
                  }
                  context.read<AuthBloc>().add(TaskUpdateEvent(
                      context: context, userTaskList: userTasksList));
                }
              }
            },
            selected: const {false},
          ),
          // floatingActionButton: FloatingActionButton.small(
          //     child: Icon(Icons.add), onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddTaskPage(),
          //   ),
          // );
          // }),
          body: SingleChildScrollView(
            controller: ScrollController(),
            child: state is AuthLoaded
                ? Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            color: MaterialColors.deepOrange.shade100),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Total      "),
                              Text("${state.userProfile.tasks.length}")
                            ])),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("    Pending  ",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade300)),
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text("      "),
                              ),
                              Text("    Finished  ",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade300)),
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.green.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text("      "),
                              ),
                            ],
                          ),
                          const Text("   ")
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: InkWell(
                            onTap: () {
                              if (isPendingStatus == true) {
                                isPendingStatus = !isPendingStatus;
                                isPendingStatusValue = "done";
                              } else {
                                isPendingStatus = !isPendingStatus;
                                isPendingStatusValue = "pending";
                              }
                              ///// used setState due to the time issue
                              setState(() {});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: MaterialColors.deepOrange.shade100
                                        .withOpacity(0.4),
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: MaterialColors
                                                .deepOrange.shade800))),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: isPendingStatus
                                      ? Icon(Icons.pending_actions)
                                      : Icon(Icons.check_circle),
                                )),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextField(
                                controller: filterControler,
                                decoration: const InputDecoration(
                                    hintText: "  Filter"))),
                        IconButton(
                            onPressed: () {
                              if (filterControler.text.isEmpty) {
                                isFilter = false;
                              } else {
                                isFilter = true;
                                filterValue = filterControler.text;
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: isFilter
                            ? state.userProfile.tasks
                                .where((element) =>
                                        element.status ==
                                            isPendingStatusValue &&
                                        element.catg
                                            .toString()
                                            .toLowerCase()
                                            .contains(filterValue)
                                    // ||
                                    // element.taskName.contains(filterValue) ||
                                    // element.taskDesc.contains(filterValue)
                                    )
                                .length
                            : state.userProfile.tasks.length,
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemBuilder: (BuildContext context, int index) {
                          var data;
                          if (isFilter) {
                            data = state.userProfile.tasks
                                .where((element) =>
                                        element.status ==
                                            isPendingStatusValue &&
                                        element.catg
                                            .toString()
                                            .toLowerCase()
                                            .contains(filterValue)
                                    // ||
                                    // element.taskName.contains(filterValue) ||
                                    // element.taskDesc.contains(filterValue)
                                    )
                                .toList()[index];
                          } else {
                            data = state.userProfile.tasks[index];
                          }

                          var _dateTime = DateTime.parse(data.dateTime);

                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade50,
                                      border: Border(
                                          left: BorderSide(
                                        width: 10,
                                        color: data.status == "pending"
                                            ? Colors.red.shade100
                                            : Colors.green.shade800,
                                      ))),
                                  child: ListTile(
                                      //             child: Icon(Icons.history)))),

                                      title: Text(data.taskName),
                                      subtitle: RichText(
                                          text: TextSpan(
                                              text: '${data.catg}: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: data.status ==
                                                              "pending"
                                                          ? Colors.red.shade400
                                                          : Colors
                                                              .green.shade800,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '${_dateTime.year}-${_dateTime.month}-${_dateTime.day} ${Helpers.formatTime(_dateTime)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Colors
                                                            .blueGrey.shade400,
                                                        fontWeight:
                                                            FontWeight.w500))
                                          ])),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateTaskPage(
                                                      taskIndex: index,
                                                      taskData: data,
                                                      TaskList: state
                                                          .userProfile.tasks,
                                                    )));
                                      },
                                      trailing: Checkbox(
                                          value: userTasksMarkedByIndex
                                              .contains(index),
                                          onChanged: (v) {
                                            if (userTasksMarkedByIndex
                                                .contains(index)) {
                                              userTasksMarkedByIndex
                                                  .remove(index);
                                            } else {
                                              userTasksMarkedByIndex.add(index);
                                            }
                                            /////// use setstate due to the time issue
                                            setState(() {});
                                          })))).animate().fade(
                              duration: const Duration(milliseconds: 300),
                              delay: Duration(milliseconds: 200 * index));
                        })
                  ])
                : Center(
                    child: Container(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator())),
          ));
    });

    /////////////
  }
}

  // options(context, {required String Catg}) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(20),
  //         ),
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Card(
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: 4, // 3 items and a delete option
  //               itemBuilder: (context, index) {
  //                 if (index < 3) {
  //                   // Build ListTile for first 3 items
  //                   return ListTile(
  //                     title: Text('Item ${index + 1}'),
  //                     onTap: () {
  //                       // Do something when an item is tapped
  //                     },
  //                   );
  //                 } else {
  //                   // Build delete option in the middle
  //                   return ListTile(
  //                     title: Center(
  //                       child: Text(
  //                         'Delete',
  //                         style: TextStyle(color: Colors.red),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       // Do something when delete is tapped
  //                     },
  //                   );
  //                 }
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
