// user_service.dart
import 'package:dio/dio.dart';
import 'package:brichbackoffice/data/entities/user.dart';
import 'package:brichbackoffice/data/entities/wallet.dart';

class UserService {
  final Dio _dio;

  UserService() : _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000/auth',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // Fetch All Users
  Future<List<User>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      _validateResponse(response);
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Fetch User by ID
  Future<User> fetchUserById(String userId) async {
    try {
      final response = await _dio.get('/users/$userId');
      _validateResponse(response);
      return User.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Fetch All Wallets
  Future<List<Wallet>> fetchWallets() async {
    try {
      final response = await _dio.get('/wallets');
      _validateResponse(response);
      return (response.data as List)
          .map((json) => Wallet.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Fetch User Wallets
  Future<List<Wallet>> getUserWallets(String userId) async {
    try {
      final response = await _dio.get('/user-wallet/$userId');
      _validateResponse(response);
      
      if (response.data['success'] == true && response.data['wallet'] != null) {
        final walletsData = response.data['wallet'] as List;
        return walletsData.map((json) => Wallet.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Validate Response
  void _validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  // Handle Error
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Connection timeout');
        case DioExceptionType.connectionError:
          return Exception('No internet connection');
        default:
          return Exception(error.message ?? 'Unknown error occurred');
      }
    }
    return Exception(error.toString());
  }
}