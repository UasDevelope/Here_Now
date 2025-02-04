import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:here_now/app/bindings/initial_binding.dart';
import 'package:here_now/app/pages/pages.dart';
import 'package:here_now/app/routes/routes.dart';
import 'package:here_now/app/utils/pref_util.dart';

import 'app/utils/images.dart';

final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtil.init();
  await dotenv.load(fileName: 'assets/.env');
  changeStatusBar();
  runApp(MyApp());
}

void changeStatusBar() {
  //
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
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
