import 'package:flutter/material.dart';

class UserDetailsTile extends StatelessWidget {
  const UserDetailsTile({Key? key, required this.content}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade800,
      title: Text(
        content,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
