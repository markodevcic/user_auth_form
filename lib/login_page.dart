import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_form/validation.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Validation validate = Validation();

  RxBool isLoading = false.obs;

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
                TextFormField(
                  controller: _username,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                TextFormField(
                  controller: _password,
                  textInputAction: TextInputAction.go,
                  style: TextStyle(fontSize: 18),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final bool canAttemptLogin = validate.form(_username.text, _password.text);
                    if (canAttemptLogin) {
                      isLoading.value = true;
                      await validate.login(_username.text, _password.text);
                      isLoading.value = false;
                    }
                  },
                  child: Obx(
                    () => (isLoading.value == true)
                        ? CircularProgressIndicator.adaptive()
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
