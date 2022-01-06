import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_form/app/data/services/server_connection.dart';
import 'package:user_auth_form/app/global_widgets/login_button.dart';

import '/app/data/services/form_validation.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final ServerConnection authenticate = ServerConnection();

  final RxBool isLoading = false.obs;

  Future startLogin() async {
    isLoading.value = true;
    final bool canAttemptLogin = Validate.form(_username.text, _password.text);
    if (canAttemptLogin) {
      await authenticate.login(_username.text, _password.text);
    }
    isLoading.value = false;
  }

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
                  style: TextStyle(fontSize: 40),
                ),
                Flexible(child: SizedBox(height: 77)),
                TextFormField(
                  controller: _username,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white12,
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
                  onFieldSubmitted: (value) => startLogin(),
                  autocorrect: false,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                Flexible(child: SizedBox(height: 32)),
                LoginButton(
                  onPressed: () => startLogin(),
                  child: Obx(
                    () => (isLoading.value == true)
                        ? Transform.scale(
                            scale: 0.7,
                            child: CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text('Log in', style: TextStyle(fontSize: 18, color: Colors.white)),
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
