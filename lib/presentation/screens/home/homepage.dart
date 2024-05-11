import 'package:abshartodo/helpers/time_format.dart';
import 'package:abshartodo/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:abshartodo/services/notification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../contants/apptheme.dart';
import '../../../contants/logout.dart';
import '../../../utils/assets.dart';
import '../auth/profile.dart';
import '../task/add_task.dart';
import '../task/all_tasks.dart';
import '../task/update_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // military_tech_outlined
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      return Services.logoutF(context);
    }, child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                leading: const SizedBox(width: 0),
                title: const Text("Todo Task"),
                centerTitle: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()));
                      },
                      icon: state is AuthLoaded
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CircleAvatar(
                                  child: CachedNetworkImage(
                                imageUrl: state.userProfile.profileImageUrl,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2)),
                                errorWidget: (context, url, error) =>
                                    Image.asset(Assets.user),
                              )),
                            )
                          : Image.asset(Assets.user)),
                ]),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(),
                child: state is AuthLoaded
                    ? Column(children: [
                        const SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconBox(
                                      icon: Icons.account_tree_sharp,
                                      title: 'Total Task',
                                      total:
                                          "${state.userProfile.tasks.length}",
                                      onTap: () {})
                                  .animate(
                                    delay: 500.ms,
                                    // onPlay: (controller) => controller.repeat()
                                  )
                                  .fade(
                                    duration: const Duration(seconds: 1),
                                    // delay: const Duration(milliseconds: 500)
                                  ),
                              IconBox(
                                      icon: Icons.pending_actions,
                                      title: 'Pending',
                                      total:
                                          "${state.userProfile.tasks.where((element) => element.status == "pending").length}",
                                      notch: Notch.none,
                                      onTap: () {})
                                  .animate(
                                    delay: 700.ms,
                                    // onPlay: (controller) => controller.repeat()
                                  )
                                  .fade(
                                      duration: const Duration(seconds: 1),
                                      delay: const Duration(milliseconds: 700)),
                              IconBox(
                                      icon: Icons.task_alt,
                                      title: 'Complete',
                                      total:
                                          "${state.userProfile.tasks.where((element) => element.status == "done").length}",
                                      notch: Notch.rightTop,
                                      onTap: () {})
                                  .animate(
                                    delay: 900.ms,
                                    // onPlay: (controller) => controller.repeat()
                                  )
                                  .fade(
                                      duration: const Duration(seconds: 1),
                                      delay: const Duration(milliseconds: 900)),
                            ]),

                        /////////////////
                        const SizedBox(height: 40),
                        Card(
                                color: MaterialColors.deepOrange.shade100,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddTaskPage(
                                            TaskList: state.userProfile.tasks,
                                          ),
                                        ),
                                      );
                                    },
                                    trailing: const CircleAvatar(
                                        child: Icon(Icons.add)),
                                    title: const Text("Add New Task"),
                                    leading: Transform.translate(
                                      offset: const Offset(10, -20),
                                      child: Transform.scale(
                                        scale: 1.5,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child: Image.asset(
                                              Assets.splash,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                            )),
                                      ),
                                    )))
                            .animate(
                                delay: 4000.ms,
                                onPlay: (controller) => controller.repeat())
                            .shakeX()
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                delay: const Duration(milliseconds: 1000))
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                delay: const Duration(milliseconds: 7000),
                                curve: Curves.easeInOut),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text("      "),
                                  ),
                                  Text("    Finished  ",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade300)),
                                  Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade200,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text("      "),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.037,
                                    child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AllTaskPage()));
                                            },
                                            child: const Text("view All"))
                                        .animate(
                                            delay: 2500.ms,
                                            onPlay: (controller) =>
                                                controller.repeat())
                                        .scale(
                                            begin: const Offset(0.7, 1),
                                            end: const Offset(1, 1))
                                        .shimmer(
                                            color: MaterialColors.deepOrange,
                                            duration:
                                                const Duration(seconds: 4),
                                            delay: const Duration(
                                                milliseconds: 1000))
                                        .shimmer(
                                            duration:
                                                const Duration(seconds: 2),
                                            curve: Curves.easeInOut)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        ListView.builder(
                            itemCount: state.userProfile.tasks.length,
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              // var data = vmValue.coachesList[index];
                              var data = state.userProfile.tasks[index];
                              var _dateTime = DateTime.parse(data.dateTime);

                              return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
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
                                              // leading: Hero(
                                              //     tag: index.toString(),
                                              //     child: ClipRRect(
                                              //         borderRadius:
                                              //             BorderRadius.circular(25),
                                              //         child: CircleAvatar(
                                              //             child: Image.asset(
                                              //                 Assets.user)))),
                                              title: Text("${data.taskName}"),
                                              subtitle: RichText(
                                                  text: TextSpan(
                                                      text: '${data.catg}: ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color: data.status == "pending"
                                                                  ? Colors.red
                                                                      .shade400
                                                                  : Colors.green
                                                                      .shade800,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            '${_dateTime.year}-${_dateTime.month}-${_dateTime.day} ${Helpers.formatTime(_dateTime)}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade400,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
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
                                                    ),
                                                  ),
                                                );
                                              },
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateTaskPage(
                                                          taskIndex: index,
                                                          taskData: data,
                                                          TaskList: state
                                                              .userProfile
                                                              .tasks,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(
                                                      Icons.double_arrow_sharp,
                                                      color: Colors.blueGrey
                                                          .shade300)))))
                                  .animate()
                                  .fade(
                                      duration: const Duration(milliseconds: 300),
                                      delay: Duration(milliseconds: 200 * index));
                            })
                      ])
                    : Center(
                        child: Container(
                          padding: const EdgeInsets.all(50),
                          child: const CircularProgressIndicator(),
                        ),
                      )));
      },
    ));
  }
}

enum Notch { leftTop, rightTop, none }

class IconBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String total;
  final Function() onTap;
  final Notch notch;
  const IconBox({
    super.key,
    required this.icon,
    required this.title,
    required this.total,
    required this.onTap,
    this.notch = Notch.leftTop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.28,
          decoration: BoxDecoration(
              color: MaterialColors.deepOrange.shade100,
              borderRadius: notch == Notch.none
                  ? BorderRadius.circular(10)
                  : notch == Notch.rightTop
                      ? const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15))
                      : const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
              border: Border.all(width: 1, color: MaterialColors.deepOrange)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.deepOrange.shade300,
                size: 50,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.deepOrange),
              ),
              const SizedBox(
                  height: 2,
                  child: Divider(thickness: 1, color: Colors.deepOrange)),
              Text(
                "$total",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.deepOrange, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
