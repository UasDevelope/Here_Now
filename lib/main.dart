import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/bindings/initial_binding.dart';
import 'package:here_now/app/pages/pages.dart';
import 'package:here_now/app/routes/routes.dart';
import 'package:here_now/app/utils/pref.dart';
import 'package:here_now/app/utils/pref_util.dart';

import 'app/utils/images.dart';
import 'firebase_options.dart';


void main() async {
  // Ensure initialization of Firebase and preferences
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefUtil.init(); // Initialize preferences only once
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