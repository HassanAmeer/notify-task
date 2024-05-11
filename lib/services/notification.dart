// ///////////////required some permissisions/////////////
// 🟢 1. go to path: android/app/src/main/AndroidManifest.xml
// 🟢 2. paste this tag Code between <permission> tag:

// <receiver
//     android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
//     android:enabled="true"
//     android:exported="false">
//     <intent-filter>
//         <action android:name="android.intent.action.BOOT_COMPLETED" />
//         <action android:name="android.intent.action.MY_PACKAGE_REPLACED" />
//     </intent-filter>
// </receiver>
// ====== Permission is ended ===========

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// first add this package
// 👉 dependencies:
//   flutter_local_notifications: ^13.0.0
// after add this dependencies

// 🟢 1. this is in main.dart page
// ----------------------------
// ////// make a globaly local notifications
// FlutterLocalNotificationsPlugin notificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
// 🟢 2. WidgetsFlutterBinding.ensureInitialized();
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

/////////////////// start initilization in main() function befor run
//  InitializationSettings initializationSettings = const InitializationSettings(
//     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//     iOS: DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestCriticalPermission: true,
//         requestSoundPermission: true));

// bool? initialized = await notificationsPlugin.initialize(
//     initializationSettings, onDidReceiveNotificationResponse: (response) {
//   debugPrint(response.payload.toString());
// });
// debugPrint("📱 check Initiliazed Notification: $initialized");
//////////////// end of initilization
//   runApp(const Home());
// }
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// 🟢 3. paste this code in any page where want to call by button
// A- for without button : before initial sate in stateful widget
// /////////////////////////////
// B- Call This Function On Button Click
// -------------------------------------
// onPressed: showNotification,
// -------------------------------------
// void showNotification(
//     {String title = "Title Abc",
//     String body = "body Message",
//     String imageUrl = "https://www.iconpacks.net/icons/2/free-discount-icon-2045-thumb.png"}) async {
//   final String largeIconPath = await _downloadAndSaveFile(
//       "https://www.iconpacks.net/icons/2/free-discount-icon-2045-thumb.png",
//       'largeIcon'); // for right side icon like for brands icon or company icon etc
//   final String bigPicturePath = await _downloadAndSaveFile(imageUrl,
//       'bigPicture'); // show the large image like for blog post and for description

//   await notificationsPlugin.show(
//       1,
//       title,
//       body,
//       NotificationDetails(
//           android: AndroidNotificationDetails(
//             "channel id",
//             "Channel name",
//             priority: Priority.max,
//             importance: Importance.high,
//             // optional: for show right side company or brand icon
//             largeIcon: FilePathAndroidBitmap(largeIconPath),
//             // optional: show the large image like for blog post and for description
//             styleInformation: BigPictureStyleInformation(
//               FilePathAndroidBitmap(bigPicturePath),
//               hideExpandedLargeIcon:
//                   false, // if true then large icon on collapse then show if expanded then then hide
//               contentTitle: '<b>big</b> content title', // can in html format
//               htmlFormatContentTitle: true,
//               summaryText: 'summary <i>text</i>', // can in html format
//               htmlFormatSummaryText: true,
//             ),
//           ),
//           iOS: const DarwinNotificationDetails(
//               presentAlert: true, presentBadge: true, presentSound: true)));
// }

//   /////////////////////////////////////
// -------------------
import 'package:timezone/timezone.dart' as tz;

showNotification(
    {String title = "Title Abc",
    String body = "body Message",
    int executionTimeMilliseconds = 1000}) async {
  try {
    await notificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        tz.TZDateTime.now(tz.local)
            .add(Duration(milliseconds: executionTimeMilliseconds)),
        const NotificationDetails(
            android: AndroidNotificationDetails("channel id", "Channel name",
                priority: Priority.max, importance: Importance.high),
            iOS: DarwinNotificationDetails(
                presentAlert: true, presentBadge: true, presentSound: true)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  } catch (e, stackTrace) {
    debugPrint(
        "💥 showNotification->tryCatch Error: $e, stackTrace:$stackTrace");
  }
}
