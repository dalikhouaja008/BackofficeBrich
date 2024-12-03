import 'package:get/get.dart';
import 'package:brichbackoffice/data/repositories/SigninRepository.dart'; // Importez votre repository

class AuthViewModel extends GetxController {
  final SigninRepository _signinRepository;

  AuthViewModel(this._signinRepository); // Injection du repository
  
  var isLoading = false.obs;
  var loginError = ''.obs;

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    loginError.value = '';
    
    try {
      bool success = await _signinRepository.signIn(email, password);

      if (success) {
        // Gérer la réponse de succès ici (ex: stockage du token)
      } else {
        loginError.value = 'Erreur lors de la connexion';
      }
    } catch (e) {
      loginError.value = 'Erreur réseau : $e';
    } finally {
      isLoading.value = false;
    }
  }
}