import 'package:get/get.dart';
import 'package:survey_app_admin/app/modules/list_user/controllers/list_user_controller.dart';
import 'package:survey_app_admin/app/modules/survey_answer/controllers/survey_answer_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(ListUserController());
    Get.put(SurveyAnswerController());
  }
}
