import 'package:brichbackoffice/data/entities/transaction.dart';
import 'package:brichbackoffice/data/entities/wallet.dart';
import 'package:brichbackoffice/data/repositories/WalletRepository.dart';
import 'package:flutter/material.dart';


class WalletsViewModel with ChangeNotifier {
  final WalletRepository _repository;

  WalletsViewModel(this._repository);

  List<Wallet> _wallets = [];
  List<Transaction> _recentTransactions = [];
  double _totalBalance = 0.0;
  String _errorMessage = '';

  List<Wallet> get wallets => _wallets;
  List<Transaction> get recentTransactions => _recentTransactions;
  double get totalBalance => _totalBalance;
  String get errorMessage => _errorMessage;

  /// Fetch all wallets and calculate total balance
  Future<void> fetchWallets() async {
    try {
      _errorMessage = '';
      _wallets = await _repository.fetchWallets();
      _calculateTotalBalance();
    } catch (e) {
      _errorMessage = 'Failed to fetch wallets: $e';
    }
    notifyListeners();
  }

  /// Fetch recent transactions
  Future<void> fetchRecentTransactions() async {
    try {
      _errorMessage = '';
      _recentTransactions = await _repository.fetchRecentTransactions();
    } catch (e) {
      _errorMessage = 'Failed to fetch recent transactions: $e';
    }
    notifyListeners();
  }

  /// Calculate the total balance from wallets
  void _calculateTotalBalance() {
    _totalBalance = _wallets.fold(0, (sum, wallet) => sum + wallet.balance);
  }
}
