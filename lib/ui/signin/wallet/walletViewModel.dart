import 'package:flutter/material.dart';

class WalletsViewModel with ChangeNotifier {
  List<Wallet> _wallets = [];
  List<Transaction> _recentTransactions = [];
  double _totalBalance = 0.0;

  List<Wallet> get wallets => _wallets;
  List<Transaction> get recentTransactions => _recentTransactions;
  double get totalBalance => _totalBalance;

  void fetchWallets() {
    // Simuler les données (ajoutez votre API ou logique ici)
    _wallets = [
      Wallet(walletName: 'US Dollar', balance: 500.0, user: 'John Doe'),
      Wallet(walletName: 'Euro', balance: 300.0, user: 'Jane Doe'),
    ];
    calculateTotalBalance();
    notifyListeners();
  }

  void fetchRecentTransactions() {
    _recentTransactions = [
      Transaction(amount: 50.0, type: 'Deposit', wallet: 'US Dollar', createdAt: DateTime.now()),
      Transaction(amount: -20.0, type: 'Withdrawal', wallet: 'Euro', createdAt: DateTime.now()),
    ];
    notifyListeners();
  }

  void calculateTotalBalance() {
    _totalBalance = _wallets.fold(0, (sum, wallet) => sum + wallet.balance);
  }
}
