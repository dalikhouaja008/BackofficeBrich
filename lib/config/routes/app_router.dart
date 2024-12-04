

import 'package:brichbackoffice/data/repositories/SigninRepository.dart';
import 'package:brichbackoffice/ui/Conversions/conversionView.dart';
import 'package:brichbackoffice/ui/mainScreen/mainScreenViewModel.dart';
import 'package:brichbackoffice/ui/mainScreen/main_screen.dart';
import 'package:get/get.dart';
import 'package:brichbackoffice/ui/signin/signinView.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart'; // Importez le ViewModel

abstract class AppRoutes {
  static const String mainPage = '/';
  static const String loginPage = '/login';
  static const String dashboardPage = '/dashboard';
   static const String conversions = '/conversions';

  static List<GetPage> pages = [
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SigninRepository>(() => SigninRepository());
        Get.lazyPut<AuthViewModel>(() => AuthViewModel(Get.find<SigninRepository>()));
      }),
    ),
      GetPage(
      name: dashboardPage,
      page: () => const AdminDashboardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<Mainscreenviewmodel>(
          () => Mainscreenviewmodel(),
        );
      }),
    ),
     GetPage(name: conversions, page: () => const ConversionsScreen()),
  ];
}