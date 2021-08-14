import 'package:flutter/material.dart';

class UnreadCountWidget extends StatelessWidget {
  final int unreadCount;

  const UnreadCountWidget({Key? key, int? unreadCount})
      : this.unreadCount = unreadCount ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: unreadCount != 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: unreadCount < 10 ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: unreadCount < 10 ? null : BorderRadius.circular(16),
          ),
          child: Text(
            '$unreadCount',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
