import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuel_station/controller/user_controller.dart';
import 'package:fuel_station/screens/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/app_theme.dart';
import 'main_wrapper.dart';

void main() async {
  await GetStorage.init();
  Get.put<UserController>(UserController());

  final userController = Get.find<UserController>();
  final userId = userController.user.value['userId'];

  Widget initialPage;

  if (userId != null) {
    initialPage = const MainWrapper();
  } else {
    initialPage = LoginPage();
  }

  runApp(
    GetMaterialApp(
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      home: initialPage,
      // home: const MainWrapper(),
    ),
  );
}
