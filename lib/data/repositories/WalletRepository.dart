import 'package:dio/dio.dart';
import '../entities/wallet.dart';
import '../entities/transaction.dart';

class WalletRepository {
  final Dio _dio;

  WalletRepository(this._dio);

  /// Fetch the list of wallets from the backend
  Future<List<Wallet>> fetchWallets() async {
    try {
      final response = await _dio.get('/wallets'); // Replace with your endpoint
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Wallet.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch wallets');
      }
    } catch (e) {
      throw Exception('Error fetching wallets: $e');
    }
  }

  /// Fetch recent transactions
  Future<List<Transaction>> fetchRecentTransactions() async {
    try {
      final response = await _dio.get('/transactions/recent'); // Replace with your endpoint
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }
  }

  /// Fetch transactions by wallet ID
  Future<List<Transaction>> fetchWalletTransactions(String walletId) async {
    try {
      final response = await _dio.get('/wallets/$walletId/transactions'); // Replace with your endpoint
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch wallet transactions');
      }
    } catch (e) {
      throw Exception('Error fetching wallet transactions: $e');
    }
  }
}
