import 'package:fitverse/screen/login.dart';
import 'package:flutter/material.dart';

void openDialog(context, title, message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          title: Text(title),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
                child: Text('OK'))
          ],
        );
      });
}
