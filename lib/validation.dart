import 'dart:async';
import 'dart:convert' show json, base64, ascii;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:user_auth_form/user_page.dart';

class Validation {
  final String url = 'https://api.getcountapp.com/api/v1/authenticate';
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Map jsonPayload = {'username': 'john@doe.com', 'password': 'test12'};

  bool form(String username, String password) {
    late String message;
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username)) {
      message = 'Enter valid email';
      showSnackbar(message);
      return false;
    } else if (password.length < 6) {
      message = 'Password must be at least 6 characters long';
      showSnackbar(message);
      return false;
    }
    return true;
  }

  Future login(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: json.encode({"username": username, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        var decodedJson = json.decode(response.body);
        // storage.write(key: username, value: decodedJson);
        var firstName = decodedJson['user']['firstName'];
        var lastName = decodedJson['user']['lastName'];
        return Get.off(() => UserPage(), arguments: [firstName, lastName]);
      } else {
        var decodedJson = json.decode(response.body.toString());
        return showSnackbar(decodedJson['errorMessage'].toString());
      }
    } on TimeoutException {
      return showSnackbar('Connection timeout, please try again');
    } on SocketException {
      return showSnackbar('No internet connection');
    }
  }

  showSnackbar(String errorMessage) {
    Get.snackbar(
      'Warning',
      errorMessage,
      overlayBlur: 1,
      overlayColor: Colors.black.withOpacity(0.2),
      icon: Icon(Icons.warning),
      backgroundColor: Colors.red.withOpacity(0.5),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
