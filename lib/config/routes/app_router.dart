import 'package:brichbackoffice/data/repositories/SigninRepository.dart';
import 'package:brichbackoffice/ui/Conversions/conversionView.dart';
import 'package:brichbackoffice/ui/mainScreen/mainScreenViewModel.dart';
import 'package:brichbackoffice/ui/mainScreen/main_screen.dart';
import 'package:brichbackoffice/ui/wallet/walletViewModel.dart';
import 'package:get/get.dart';
import 'package:brichbackoffice/ui/signin/signinView.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart'; // Importez le ViewModel
import 'package:brichbackoffice/ui/wallet/walletsScreen.dart'; // Import Wallet Screen
import 'package:brichbackoffice/data/repositories/WalletRepository.dart'; // Import Wallet Repository

abstract class AppRoutes {
  static const String mainPage = '/';
  static const String loginPage = '/login';
  static const String dashboardPage = '/dashboard';
  static const String conversions = '/conversions';
  static const String walletPage = '/wallet';

  static List<GetPage> pages = [
    // Login Page
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SigninRepository>(() => SigninRepository());
        Get.lazyPut<AuthViewModel>(() => AuthViewModel(Get.find<SigninRepository>()));
      }),
    ),

    // Dashboard Page
    GetPage(
      name: dashboardPage,
      page: () => const AdminDashboardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<Mainscreenviewmodel>(() => Mainscreenviewmodel());
      }),
    ),

    // Conversions Page
    GetPage(
      name: conversions,
      page: () => const ConversionsScreen(),
    ),

    // Wallet Page (Updated to navigate properly)
    GetPage(
      name: walletPage,
      page: () => const WalletsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<WalletsViewModel>(() => WalletsViewModel(Get.find<WalletRepository>()));
      }),
    ),
  ];
}
