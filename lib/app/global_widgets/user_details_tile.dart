import 'package:flutter/material.dart';

class UserDetailsTile extends StatelessWidget {
  const UserDetailsTile({Key? key, required this.content, required this.title}) : super(key: key);

  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Colors.grey.shade800,
        title: Text(title,
            textAlign: TextAlign.justify, style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7))),
        subtitle: Text(
          content,
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
