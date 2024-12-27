import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/bindings/initial_binding.dart';
import 'package:here_now/app/pages/pages.dart';
import 'package:here_now/app/routes/routes.dart';

import 'app/utils/images.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Here-Now App',
      initialBinding: InitialBinding(),
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
    );
  }
}