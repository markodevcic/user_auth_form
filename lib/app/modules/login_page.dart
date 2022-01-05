import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_form/app/data/services/server_connection.dart';

import '/app/data/services/form_validation.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final ServerConnection authenticate = ServerConnection();

  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login', style: TextStyle(fontSize: 18)),
          centerTitle: true,
        ),
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 48),
                ),
                SizedBox(height: 88),
                TextFormField(
                  controller: _username,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white12,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Username',
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _password,
                  textInputAction: TextInputAction.go,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white12,
                    filled: true,
                    focusColor: Colors.orange,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 52),
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                    onPressed: () async {
                      final bool canAttemptLogin = Validate.form(_username.text, _password.text);
                      if (canAttemptLogin) {
                        isLoading.value = true;
                        await authenticate.login(_username.text, _password.text);
                        isLoading.value = false;
                      }
                    },
                    child: Obx(
                      () => (isLoading.value == true)
                          ? CircularProgressIndicator.adaptive()
                          : Text('Log in', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
