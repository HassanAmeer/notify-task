import 'dart:io';
import 'package:abshartodo/config/hive_config.dart';
import 'package:abshartodo/data/local/local_hive.dart';
import 'package:abshartodo/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_model.dart';
import '../../models/user_tasks.dart';

class AuthRepo extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingForLogin = false;
  var userProfile = {};
  List teams = [];
  String? uid = "";
  String? userName = "";
  String? userEmail = "";
  String? imgPickerPath = "";
  String? tournamentType = "";
  //////////////////////////////////////////////////
  signoutF() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  //////////////////////////////////////////////////
  getAuthF({String? uid}) async {
    uid = uid ?? FirebaseAuth.instance.currentUser!.uid;
    /////// from database
    var checkUser =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    HiveConfig.uid;
    await LocalHive().addHiveF(key: HiveConfig.uid, data: uid);
    await LocalHive()
        .addHiveF(key: HiveConfig.todoList, data: checkUser.data());
    return checkUser.data()!;
  }

  // deleteAccountVMF(context) async {
  //   FirebaseAuth.instance.currentUser!.delete().then((value) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Account Deleted!')));
  //     Navigator.pop(context);
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const LoginPage()));
  //   }).onError((error, stackTrace) {
  //     Navigator.pop(context);
  //     // ScaffoldMessenger.of(context)
  //     //     .showSnackBar(SnackBar(content: Text('$error')));
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: const Text('Login Again To Confirm!'),
  //       action: SnackBarAction(
  //           label: 'Login',
  //           onPressed: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => const LoginPage()));
  //           }),
  //     ));
  //   });
  // }

  Future createWithEmailAndPassword(
      {String email = "", String password = ""}) async {
    signoutF();
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    var userName = user!.email.toString().split('@');
    return await registeredVmF(
        uid: user.uid.toString(),
        email: user.email.toString(),
        name: userName.first);
  }

  registeredVmF({uid = "abc", email = "", name = "Name"}) async {
    var checkUser =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (checkUser.data() != null &&
        checkUser.data()!['uid'].toString().toLowerCase() ==
            uid.toString().toLowerCase()) {
      // debugPrint("👉 userProfile: ${checkUser.data().toString()}");
      return await getAuthF();
    }
    // final userProfile = {
    //   "uid": "$uid",
    //   "email": "$email",
    //   "tasks": [
    //     {
    //       "taskName": "name",
    //       "taskDesc": "taskDesc",
    //       "catg": "catg",
    //       "dateTime": "dateTime",
    //       "status": "status",
    //     },
    //   ],
    //   "profile":
    //       "https://firebasestorage.googleapis.com/v0/b/abshar-todo-task.appspot.com/o/usersId%2Fid786%2Fprofile.png?alt=media&token=0ff08ef8-e792-426a-9516-39d80b3307a7",
    //   "timeStamp": "${DateTime.now().microsecondsSinceEpoch}"
    // };
    // tz.TZDateTime.now(tz.local).add( Duration(milliseconds: exectTime));
    final userProfile = UserProfile(
        uid: '$uid',
        email: '$email',
        password: '123456',
        tasks: [
          UserTask(
              taskName: 'task1',
              taskDesc: 'task Description',
              catg: 'work',
              dateTime: '2024-05-05 23:10:00.000',
              miliSeconds: DateTime.now()
                  .add(const Duration(hours: 1))
                  .difference(DateTime.now())
                  .inMilliseconds
                  .toString(),
              status: 'pending')
        ],
        profileImageUrl:
            'https://firebasestorage.googleapis.com/v0/b/abshar-todo-task.appspot.com/o/usersId%2Fid786%2Fprofile.png?alt=media&token=0ff08ef8-e792-426a-9516-39d80b3307a7',
        timeStamp: DateTime.now().microsecondsSinceEpoch);
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(userProfile.toJson())
        .then((value) async => await getAuthF());
  }
  //////////////////////////////////////////////////

  Future signInWithEmailAndPassword(
      {String email = "", String password = ""}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    uid = user!.uid;
    return await getAuthF(uid: user.uid);
  }

  loginWithGoogleVMF() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      ////////
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      ////////
      // debugPrint("👉 googleAuth: ${googleAuth}");
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      // debugPrint("👉 googleAuth.idToken: ${googleAuth.idToken}");
      // debugPrint("👉 googleAuth.accessToken: ${googleAuth.accessToken}");
      ////////
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // debugPrint("👉 userCredential: ${userCredential.user!.uid}");s
      // debugPrint("Signed in as ${userCredential.user!.displayName}");
      return await registeredVmF(
          name: userCredential.user!.displayName,
          email: userCredential.user!.email,
          uid: userCredential.user!.uid);
    } else {
      debugPrint("Sign-in cancelled");
      return false;
    }
  }

  /////////////// if Not Registered Make an account
  updateImage(String imgPath) async {
    var uid = FirebaseAuth.instance.currentUser!.uid ?? "abc";
    var refProfile = FirebaseStorage.instance
        .ref()
        .child("usersId")
        .child(uid)
        .child('profile.png');
    var uploadTask = refProfile.putFile(File(imgPath));
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    final userProfile = {"profile": downloadUrl.toString()};
    // log("👉 uid:$uid, updateImage->downloadUrl:$downloadUrl");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update(userProfile);
    // log("👉 Image download URL: $downloadUrl");
    return await getAuthF();
  }

  /////////////////////////
//  updateProfileVmF(context,
//       {required String email, required String password}) async {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(uid)
//         .update({"email": email, "password": password});
//     return await getAuthF();
//   }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future updateTaskList({required List<UserTask> userTaskList}) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({
      "tasks": userTaskList.map((task) => task.toJson()).toList()
    }).then((value) async => await getAuthF());
  }

  Future taskShareByEmail(context,
      {required email, required UserTask task}) async {
    // var uid = FirebaseAuth.instance.currentUser!.uid;
    List usersTasksList = [];
    var checkUser = await FirebaseFirestore.instance.collection("users").get();
    if (checkUser.docs.isNotEmpty) {
      for (var element in checkUser.docs) {
        if (element.data()['email'] == email) {
          usersTasksList = element.data()['tasks'];
          usersTasksList.add(task.toJson());
          await FirebaseFirestore.instance
              .collection("users")
              .doc(element.id)
              .update({"tasks": usersTasksList});
          snackBarColorF("Shared!", context);
          break;
        }
      }
    } else {
      snackBarColorF("Email Not Found", context);
    }
  }
}
