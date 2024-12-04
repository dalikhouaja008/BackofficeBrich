import 'package:brichbackoffice/data/repositories/SigninRepository.dart';
import 'package:brichbackoffice/data/repositories/WalletRepository.dart';
import 'package:brichbackoffice/ui/signin/wallet/WalletsScreen.dart';
import 'package:brichbackoffice/ui/signin/wallet/walletViewModel.dart';
import 'package:get/get.dart';
import 'package:brichbackoffice/ui/signin/signinView.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart';

abstract class AppRoutes {
  static const String loginPage = '/login';
  static const String walletPage = '/wallet';

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
      name: walletPage,
      page: () => const WalletsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<WalletsViewModel>(() => WalletsViewModel(Get.find<WalletRepository>()));
      }),
    ),
  ];
}