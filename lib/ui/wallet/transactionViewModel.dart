import 'package:brichbackoffice/data/entities/transaction.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class TransactionViewModel extends GetxController {
  var transactions = <Transaction>[].obs;
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchTransactions(String walletId) async {
    try {
      final response = await _dio.get('https://api.example.com/wallets/$walletId/transactions'); // Remplacez par votre endpoint
      if (response.statusCode == 200) {
        transactions.value = (response.data as List).map((transaction) => Transaction.fromJson(transaction)).toList();
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }
}