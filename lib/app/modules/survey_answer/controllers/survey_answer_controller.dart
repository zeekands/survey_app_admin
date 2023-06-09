import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:survey_app_admin/app/data/models/survey_answer_model.dart';

class SurveyAnswerController extends GetxController {
  final ref = FirebaseFirestore.instance.collection('results');

  Stream<List<SurveyAnswer>> readResult() {
    return ref.snapshots().map(
          (list) => list.docs
              .map(
                (doc) => SurveyAnswer.fromJson(doc.data()),
              )
              .toList(),
        );
  }
}
