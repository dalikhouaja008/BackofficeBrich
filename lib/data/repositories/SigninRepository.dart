import 'package:dio/dio.dart';
// Assurez-vous d'importer votre modèle User

class SigninRepository {
  final Dio _dio = Dio();

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://yourapi.com/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // Gérer le succès, par exemple en stockant un token
        return true; // Connexion réussie
      } else {
        return false; // Échec de la connexion
      }
    } catch (e) {
      print('Erreur lors de la connexion : $e');
      throw Exception('Erreur réseau : $e');
    }
  }
}