import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey_app_admin/app/data/models/account_model.dart';
import 'package:survey_app_admin/app/modules/list_user/views/edit_account_dialog.dart';

import '../controllers/list_user_controller.dart';

class ListUserView extends GetView<ListUserController> {
  const ListUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<AccountModel>>(
        stream: controller.readAccount(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            final questionnaires = snapshot.data!;
            var listQuestionaire = <DataRow>[];
            for (int i = 0; i < questionnaires.length; i++) {
              var date = DateTime.parse(questionnaires[i].createdAt);
              var formatedDate = DateFormat('dd MMM yyyy').format(date);

              listQuestionaire.add(DataRow(cells: [
                DataCell(Text(
                  (i + 1).toString(),
                  style: TextStyle(fontSize: 16.sp),
                )),
                DataCell(Text(
                  formatedDate,
                  style: TextStyle(fontSize: 16.sp),
                )),
                DataCell(Text(
                  questionnaires[i].name,
                  style: TextStyle(fontSize: 16.sp),
                )),
                DataCell(Text(
                  questionnaires[i].npk,
                  style: TextStyle(fontSize: 16.sp),
                )),
                DataCell(Text(
                  questionnaires[i].email,
                  style: TextStyle(fontSize: 16.sp),
                )),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditDialog(
                                id: questionnaires[i].id,
                                name: questionnaires[i].name,
                                email: questionnaires[i].email,
                                password: questionnaires[i].password,
                                npk: questionnaires[i].npk,
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.deleteAccount(questionnaires[i].id);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ]));
            }
            return Container(
              width: 1.sw,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Created At')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('NPK')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: listQuestionaire,
                ),
              ),
            );
          } else {
            return const Text("No Data");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const RegisterDialog();
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;
  late String _npk;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListUserController>();
    return AlertDialog(
      title: const Text('Register User'),
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
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: .5.sw,
                  height: 60.h,
                  child: TextFormField(
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
                    onSaved: (value) {
                      _npk = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: .5.sw,
                  height: 60.h,
                  child: TextFormField(
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
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 60.h,
                  width: .5.sw,
                  child: TextFormField(
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
                    onSaved: (value) {
                      _password = value!;
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
              controller.addAccount(_name, _email, _password, _npk);

              Navigator.pop(context);
            }
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
