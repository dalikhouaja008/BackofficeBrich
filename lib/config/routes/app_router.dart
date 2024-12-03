

import 'package:brichbackoffice/data/repositories/SigninRepository.dart';
import 'package:get/get.dart';
import 'package:brichbackoffice/ui/signin/signinView.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart'; // Importez le ViewModel

abstract class AppRoutes {
  static const String loginPage = '/login';

  static List<GetPage> pages = [
    GetPage(
      name: loginPage,
      page: () => LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SigninRepository>(() => SigninRepository());
        Get.lazyPut<AuthViewModel>(() => AuthViewModel(Get.find<SigninRepository>()));
      }),
    ),
  ];
}