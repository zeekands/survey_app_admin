import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_app_admin/app/data/models/question_model.dart';

class HomeController extends GetxController {
  CollectionReference ref = FirebaseFirestore.instance.collection('question');

  final count = 0.obs;

  final titleController = TextEditingController();

  Stream<List<QuestionModel>> readQuestion() {
    return ref.snapshots().map(
          (list) => list.docs
              .map(
                (doc) =>
                    QuestionModel.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<void> addQuestion(QuestionModel question) async {
    final refDoc = ref.doc();
    final data = {
      "id": refDoc.id,
      "title": question.title,
      "createdAt": DateTime.now().toString(),
    };
    refDoc.set(data);
  }

  Future<void> updateQuestion(String id, String title) async {
    final refDoc = ref.doc(id);
    final data = {
      "id": refDoc.id,
      "title": title,
      "createdAt": DateTime.now().toString(),
    };

    refDoc.set(data);
  }

  Future<void> deleteQuestion(String id) {
    return ref
        .doc(id)
        .delete()
        .then((value) => print("Question Deleted"))
        .catchError((error) => print("Failed to delete question: $error"));
  }

  void increment() => count.value++;
}
