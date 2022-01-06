import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/global_widgets/initial_route_to_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
      ),
      home: RouteToPage(),
    );
  }
}
