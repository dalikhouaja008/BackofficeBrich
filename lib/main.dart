import 'package:brichbackoffice/config/routes/app_router.dart';
import 'package:brichbackoffice/ui/signin/signinView.dart';
import 'package:flutter/material.dart';
import 'package:brichbackoffice/injection/injection_container.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginPage,
      getPages: AppRoutes.pages,
    ),
  );
}
