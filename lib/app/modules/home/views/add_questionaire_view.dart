import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_app_admin/app/data/models/question_model.dart';

class AddQuestionnaireDialog extends StatefulWidget {
  final Function(QuestionModel) onSubmit;

  const AddQuestionnaireDialog({super.key, required this.onSubmit});

  @override
  _AddQuestionnaireDialogState createState() => _AddQuestionnaireDialogState();
}

class _AddQuestionnaireDialogState extends State<AddQuestionnaireDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _category;
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Questionnaire'),
      content: SizedBox(
        width: .5.sw,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                maxLines: 5,
                controller: titleController,
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
              final newQuestionnaire = QuestionModel(
                id: Random().nextInt(1000).toString(),
                title: titleController.text,
                createdAt: DateTime.now().toIso8601String(),
              );
              widget.onSubmit(newQuestionnaire);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
