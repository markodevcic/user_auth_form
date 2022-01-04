import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_form/user_page.dart';

import 'login_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/user_page', page: () => UserPage()),
      ],
      home: LoginPage(),
    );
  }
}
