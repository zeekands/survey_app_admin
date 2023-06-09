import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey_app_admin/app/data/models/question_model.dart';
import 'package:survey_app_admin/app/modules/home/views/add_questionaire_view.dart';
import 'package:survey_app_admin/app/modules/list_user/views/list_user_view.dart';
import 'package:survey_app_admin/app/modules/survey_answer/views/survey_answer_view.dart';
import 'package:survey_app_admin/app/routes/app_pages.dart';
import 'package:survey_app_admin/main.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return const Scaffold(
      body: MyNavigationRail(),
      resizeToAvoidBottomInset: false,
    );
  }
}

class MyNavigationRail extends StatefulWidget {
  const MyNavigationRail({super.key});

  @override
  _MyNavigationRailState createState() => _MyNavigationRailState();
}

class _MyNavigationRailState extends State<MyNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          minWidth: 200.w,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CircleAvatar(
              radius: 50.r,
              backgroundImage: const NetworkImage(
                  "https://xsgames.co/randomusers/assets/avatars/male/70.jpg"),
            ),
          ),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.assignment_add),
              label: Text('Question\n List', textAlign: TextAlign.center),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person),
              label: Text('List User'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.question_answer),
              label: Text('Survey Answer', textAlign: TextAlign.center),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.logout),
              label: Text('Logout'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Flexible(
          child: Column(
            children: [
              Builder(builder: (context) {
                var name = "";
                if (_selectedIndex == 0) {
                  name = "Question List";
                } else if (_selectedIndex == 1) {
                  name = "List User";
                } else if (_selectedIndex == 2) {
                  name = "Survey Answer";
                }
                return Container(
                  height: 100.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.blue.withOpacity(.3),
                  child: Text(name),
                );
              }),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    const Center(child: QuestionnaireListPage()),
                    const Center(child: ListUserView()),
                    const Center(child: SurveyAnswerView()),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Are you sure want to logout?"),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            box.erase();
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: const Text("Logout"),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuestionnaireListPage extends StatelessWidget {
  const QuestionnaireListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddQuestionnaireDialog(
                onSubmit: (newQuestionnaire) {
                  controller.addQuestion(newQuestionnaire);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<QuestionModel>>(
        stream: controller.readQuestion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
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
                  questionnaires[i].title,
                  style: TextStyle(fontSize: 16.sp),
                )),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          editDialog(context, questionnaires, i, controller);
                        },
                        icon: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.deleteQuestion(questionnaires[i].id);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ]));
            }
            return Container(
              padding: const EdgeInsets.all(16),
              width: 1.sw,
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Created At')),
                      DataColumn(label: Text('Question')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: listQuestionaire,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> editDialog(BuildContext context,
      List<QuestionModel> questionnaires, int i, HomeController controller) {
    controller.titleController.text = questionnaires[i].title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        return AlertDialog(
          title: const Text('Edit Questionnaire'),
          content: SizedBox(
            width: .5.sw,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    maxLines: 5,
                    controller: controller.titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      hintText: "Enter your question",
                      fillColor: Colors.grey[200],
                    ),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  controller.updateQuestion(
                      questionnaires[i].id, controller.titleController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
