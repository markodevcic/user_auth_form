import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_form/login_page.dart';
import 'package:user_auth_form/user_details_tile.dart';

class UserPage extends StatelessWidget {
  final String firstName = Get.arguments[0];
  final String lastName = Get.arguments[1];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$firstName $lastName', style: TextStyle(fontSize: 18)),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(onPressed: () => Get.off(() => LoginPage()), child: Text('Log out')),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16),
              UserDetailsTile(content: 'First name: $firstName'),
              SizedBox(height: 16),
              UserDetailsTile(content: 'Last name: $lastName'),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
