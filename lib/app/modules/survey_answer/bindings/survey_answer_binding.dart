import 'package:get/get.dart';

import '../controllers/survey_answer_controller.dart';

class SurveyAnswerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyAnswerController>(
      () => SurveyAnswerController(),
    );
  }
}
