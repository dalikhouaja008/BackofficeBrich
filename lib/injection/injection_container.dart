import 'package:brichbackoffice/data/repositories/CurrencyConverterRepository.dart';
import 'package:brichbackoffice/data/repositories/SigninRepository.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    //Packages
    Get.put(Dio());
    //repositrories
    Get.lazyPut<SigninRepository>(() => SigninRepository());
    Get.lazyPut<CurrencyConverterRepository>(
        () => CurrencyConverterRepository(Get.find<Dio>()));
    //Controllers
    Get.lazyPut<AuthViewModel>(
        () => AuthViewModel(Get.find<SigninRepository>()));
  }
}
