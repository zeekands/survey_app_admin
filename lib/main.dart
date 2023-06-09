import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:survey_app_admin/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: F,
        title: "Survey App",
        initialRoute:
            box.read(isLogin) == true ? Routes.HOME : AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}

final box = GetStorage();
const userName = 'userName';
const isLogin = 'isLogin';
