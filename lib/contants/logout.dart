import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'apptheme.dart';

class Services {
  static logoutF(context) async {
    bool quit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('Are you sure you want to quit?'),
          actions: <Widget>[
            TextButton(
              child: Text('No',
                  style: TextStyle(
                      color: MaterialColors.deepOrange.withOpacity(0.8))),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.red.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)))),
              child: Text('Yes',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.red)),
              onPressed: () async {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );

    // If the user wants to quit, close the app
    if (quit == true) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
