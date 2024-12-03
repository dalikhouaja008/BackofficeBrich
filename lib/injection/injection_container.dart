import 'package:brichbackoffice/data/repositories/SigninRepository.dart';
import 'package:brichbackoffice/ui/signin/signinViewModel.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    Get.lazyPut<SigninRepository>(() => SigninRepository());
    Get.lazyPut<AuthViewModel>(() => AuthViewModel(Get.find<SigninRepository>()));
  }
}
