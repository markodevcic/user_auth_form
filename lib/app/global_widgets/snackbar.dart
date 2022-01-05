import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String errorMessage) {
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
