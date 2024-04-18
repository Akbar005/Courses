import 'package:flutter/material.dart';

class SnackBarWidget {
  void snackBar(BuildContext context, String incomingMsg, bool success,
      {int seconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green : Colors.red,
        content: Text(
          incomingMsg,
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: seconds),
      ),
    );
  }

  void raisedSnackBar(BuildContext context, String incomingMsg, bool success,
      {int seconds = 3}) {
    var height = MediaQuery.of(context).size.height;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: height * 0.15),
        backgroundColor: success ? Colors.green : Colors.red,
        content: Text(incomingMsg, maxLines: 4, textAlign: TextAlign.center),
        duration: Duration(seconds: seconds),
      ),
    );
  }
}
