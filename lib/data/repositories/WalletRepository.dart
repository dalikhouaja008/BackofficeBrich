import 'package:dio/dio.dart';
import '../entities/wallet.dart';
import '../entities/transaction.dart';

class WalletRepository {
  final Dio _dio;

  WalletRepository(this._dio);

  /// Fetch all wallets
  Future<List<Wallet>> fetchWallets() async {
    try {
      final response = await _dio.get('/wallets'); // Endpoint correct
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Wallet.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch wallets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wallets: $e');
    }
  }

  /// Fetch recent transactions
  Future<List<Transaction>> fetchRecentTransactions() async {
    try {
      final response = await _dio.get('/transactions/recent'); // Endpoint correct
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch transactions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }
  }

  /// Fetch transactions by wallet ID
  Future<List<Transaction>> fetchWalletTransactions(String walletId) async {
    try {
      final response = await _dio.get('/wallets/$walletId/transactions'); // Endpoint correct
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch wallet transactions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wallet transactions: $e');
    }
  }

  /// Fetch wallets by user ID
  Future<List<Wallet>> fetchWalletsByUser(String userId) async {
    try {
      final response = await _dio.get('/users/$userId/wallets'); // Endpoint correct
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Wallet.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch wallets by user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wallets by user: $e');
    }
  }
}