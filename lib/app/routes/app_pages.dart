import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_user/bindings/list_user_binding.dart';
import '../modules/list_user/views/list_user_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/survey_answer/bindings/survey_answer_binding.dart';
import '../modules/survey_answer/views/survey_answer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LIST_USER,
      page: () => const ListUserView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: _Paths.SURVEY_ANSWER,
      page: () => const SurveyAnswerView(),
      binding: SurveyAnswerBinding(),
    ),
  ];
}
