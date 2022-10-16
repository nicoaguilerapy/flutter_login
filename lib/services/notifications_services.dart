import 'package:flutter/material.dart';

class NotificationsServices {
  static GlobalKey<ScaffoldMessengerState> messageKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnacBar(String message) {
    final snakBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );

    messageKey.currentState!.showSnackBar(snakBar);
  }
}
