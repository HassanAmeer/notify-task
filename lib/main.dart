import 'package:abshartodo/presentation/screens/task/bloc/task_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'contants/apptheme.dart';
import 'firebase_options.dart';
import 'presentation/screens/auth/bloc/auth_bloc.dart';
import 'presentation/screens/splash/splash_page.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  /////////////////// start initilization in main() function befor run
  InitializationSettings initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestCriticalPermission: true,
          requestSoundPermission: true));

  bool? initialized = await notificationsPlugin.initialize(
      initializationSettings, onDidReceiveNotificationResponse: (response) {
    debugPrint(response.payload.toString());
  });
  debugPrint("📱 check Initiliazed Notification: $initialized");
  //////////////// end of initilization
  tz.initializeTimeZones();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
    BlocProvider<TaskBloc>(create: (BuildContext context) => TaskBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: MaterialColors.deepOrange),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
                backgroundColor: MaterialColors.deepOrange.shade200)),
        home: const SplashPage());
  }
}
