import 'dart:convert' show json, utf8, base64;

import 'package:flutter/material.dart';
import 'package:user_auth_form/app/data/services/server_connection.dart';

import '/app/data/services/secure_storage.dart';
import '/app/modules/user_page.dart';
import '/app/modules/login_page.dart';

class RouteToPage extends StatelessWidget {
  RouteToPage({Key? key}) : super(key: key);

  final ServerConnection connect = ServerConnection();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SecureStorage.getToken,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Scaffold(appBar: AppBar(), body: Center(child: CircularProgressIndicator()));
        if (snapshot.data != '') {
          final token = snapshot.data.toString();
          var jwt = token.split('.');
          if (jwt.length != 3) {
            return LoginPage();
          } else {
            var payload = json.decode(utf8.decode(base64.decode(base64.normalize(jwt[1]))));
            if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000).isAfter(DateTime.now())) {
              return UserPage(token);
            } else {
              return LoginPage();
            }
          }
        } else {
          return LoginPage();
        }
      },
    );
  }
}
