import 'package:biswas_shop_admin_panel/firebase_options.dart';
import 'package:biswas_shop_admin_panel/screens/main_screen.dart';
import 'package:biswas_shop_admin_panel/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      builder: EasyLoading.init(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppConstant.appMainColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black),
          )
      ),
    );
  }
}
