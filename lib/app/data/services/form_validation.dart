import 'package:user_auth_form/app/global_widgets/snackbar.dart';

class Validate {
  static bool form(String username, String password) {
    late String message;
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username)) {
      message = 'Enter valid email';
      showSnackBar(message);
      return false;
    } else if (password.length < 6) {
      message = 'Password must be at least 6 characters long';
      showSnackBar(message);
      return false;
    }
    return true;
  }
}
