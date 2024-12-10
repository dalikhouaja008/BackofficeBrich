import 'package:brichbackoffice/config/routes/app_router.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WalletsViewModel(WalletRepository(Dio())),
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
