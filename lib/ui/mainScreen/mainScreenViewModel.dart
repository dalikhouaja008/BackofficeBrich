import 'package:brichbackoffice/ui/signin/signinView.dart';
import 'package:get/get.dart';

class Mainscreenviewmodel  extends GetxController {
  // Vous pouvez ajouter des variables réactives ici si nécessaire
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }

  // Méthode de déconnexion
  void logout() {
    // Logique de déconnexion
    Get.offAll(() => const LoginPage());
  }
}