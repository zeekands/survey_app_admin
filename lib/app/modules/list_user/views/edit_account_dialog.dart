// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/list_user_controller.dart';

class EditDialog extends StatefulWidget {
  const EditDialog(
      {Key? key, this.id, this.name, this.email, this.password, this.npk})
      : super(key: key);
  final id;
  final name;
  final email;
  final password;
  final npk;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListUserController>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final npkController = TextEditingController();

    nameController.text = widget.name;
    emailController.text = widget.email;
    passwordController.text = widget.password;
    npkController.text = widget.npk;

    return AlertDialog(
      title: const Text('Edit User'),
      content: SizedBox(
        width: .5.sw,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60.h,
                  width: .5.sw,
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 18.sp),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: .5.sw,
                  height: 60.h,
                  child: TextFormField(
                    controller: npkController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'NPK',
                      labelStyle: TextStyle(fontSize: 18.sp),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your NPK';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: .5.sw,
                  height: 60.h,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 18.sp),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 60.h,
                  width: .5.sw,
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 18.sp),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Perform registration logic
              controller.updateAccount(
                widget.id,
                nameController.text,
                emailController.text,
                passwordController.text,
                npkController.text,
              );

              Navigator.pop(context);
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
