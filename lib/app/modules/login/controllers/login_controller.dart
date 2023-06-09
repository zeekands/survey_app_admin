import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_app_admin/app/routes/app_pages.dart';
import 'package:survey_app_admin/main.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    // Query Firestore for user document with matching email
    final userQuery = await FirebaseFirestore.instance
        .collection('account')
        .where('email', isEqualTo: emailController.text)
        .limit(1)
        .get();
    if (emailController.text == "admin@gmail.com") {
      if (userQuery.size == 1) {
        final userDoc = userQuery.docs.first;
        final storedPassword = userDoc.data()['password'];

        if (passwordController.text == storedPassword) {
          // Login successful, navigate to home page
          box.write(isLogin, true);
          box.write(userName, userDoc.data()['name']);
          Get.toNamed(Routes.HOME);
          return;
        }
      }
    }
    // Login failed, show error message
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid email or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
