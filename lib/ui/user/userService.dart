import 'package:dio/dio.dart';
import 'package:brichbackoffice/data/entities/user.dart';

class UserService {
  final Dio _dio = Dio();

  UserService() {
    _dio.options.baseUrl = 'http://localhost:3000/auth';
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      if (response.statusCode == 200) {
        return (response.data as List).map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Erreur réseau: ${e.message}');
    }
  }

  Future<User> fetchUserById(String userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Erreur réseau: ${e.message}');
    }
  }

  Future<List<dynamic>> fetchUserWallets(String userId) async {
    try {
      final response = await _dio.get('/users/$userId/wallets');
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Erreur réseau: ${e.message}');
    }
  }
}
