import 'package:flutter/material.dart';

class NotificationBubble extends StatelessWidget {
  final int notifications;

  const NotificationBubble({Key key, this.notifications}) : super(key: key);

  Widget build(BuildContext context) {
    if (notifications > 0) {
      return Container(
        width: 30,
        height: 30,
        alignment: Alignment.topRight,
        child: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.white, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Text(
                notifications.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      );
    } else {
      return Center();
    }
  }
}
