import 'package:brichbackoffice/config/routes/app_router.dart';
import 'package:brichbackoffice/ui/user/userViewModel.dart';
import 'package:flutter/material.dart';
import 'package:brichbackoffice/injection/injection_container.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:brichbackoffice/data/repositories/WalletRepository.dart';
import 'package:brichbackoffice/ui/wallet/walletViewModel.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();

  final walletRepository = WalletRepository(Dio());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WalletsViewModel(walletRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(walletRepository),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.loginPage,
        getPages: AppRoutes.pages,
      ),
    ),
  );
}