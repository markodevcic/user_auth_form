import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key, required this.onPressed, required this.child}) : super(key: key);
  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 150,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
