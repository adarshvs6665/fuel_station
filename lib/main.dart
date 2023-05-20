import 'package:flutter/material.dart';
import 'package:fuel_station/screens/login.dart';
import 'package:get/get.dart';

import '../utils/app_theme.dart';
import 'main_wrapper.dart';

void main() => runApp(
      GetMaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        // home: const MainWrapper(),
      ),
    );
