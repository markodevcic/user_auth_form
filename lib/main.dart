import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/global_widgets/initial_route_to_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: RouteToPage(),
    );
  }
}
