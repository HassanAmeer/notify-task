import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/////////////////////////
deleteAccountAlert(context,
    {required String title, required VoidCallback onTap}) async {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: CupertinoAlertDialog(
              title: Text(title)
                  .animate(onPlay: (controller) {
                    controller.repeat();
                  })
                  .shimmer(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(seconds: 2))
                  .shimmer(
                      color: Colors.redAccent.shade200,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(seconds: 2)),
              actions: [
                CupertinoButton(
                    onPressed: onTap,
                    child: const Text(
                      'YES',
                      style: TextStyle(color: Colors.red),
                    )),
                CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('NO')),
              ],
              insetAnimationCurve: Curves.elasticInOut,
              insetAnimationDuration: const Duration(milliseconds: 1700),
            ));
      });
}
