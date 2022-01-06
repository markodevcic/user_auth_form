import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_auth_form/app/data/models/user_data.dart';

import '/app/data/services/secure_storage.dart';
import '/app/global_widgets/snackbar.dart';
import '/app/modules/user_page.dart';

class ServerConnection {
  final String loginUrl = 'https://api.getcountapp.com/api/v1/authenticate';
  final String getUserDataUrl = 'https://api.getcountapp.com/api/v1/users/me';

  Future login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: json.encode({"username": username, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final token = json.decode(response.body)['token'];

        SecureStorage.writeToken(token);

        return Get.off(() => UserPage.fromBase64(token));
      } else {
        final error = json.decode(response.body.toString());
        return showSnackBar(error['errorMessage'].toString());
      }
    } on TimeoutException {
      return showSnackBar('Connection timeout, please try again');
    } on SocketException {
      return showSnackBar('No internet connection');
    }
  }

  Future<UserData> getUserData(token) async {
    try {
      final response = await http.get(
        Uri.parse(getUserDataUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final payload = json.decode(response.body);
        return UserData.fromJson(payload);
      } else {
        return showSnackBar('Something went wrong, please reload the page');
      }
    } on TimeoutException {
      return showSnackBar('Connection timeout, please try again');
    } on SocketException {
      return showSnackBar('No internet connection');
    }
  }
}
