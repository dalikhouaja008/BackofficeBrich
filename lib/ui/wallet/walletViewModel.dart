import 'package:brichbackoffice/data/entities/transaction.dart';
import 'package:brichbackoffice/data/entities/wallet.dart';
import 'package:brichbackoffice/data/repositories/WalletRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletsViewModel extends ChangeNotifier {
  final WalletRepository walletRepository;
  List<Wallet> wallets = [];
  List<Transaction> recentTransactions = [];
  double totalBalance = 0.0;
  String errorMessage = '';
  String _searchQuery = '';

  WalletsViewModel(this.walletRepository);

  String get searchQuery => _searchQuery;

  /// Fonction pour récupérer tous les portefeuilles
  Future<void> fetchWallets() async {
    try {
      wallets = await walletRepository.fetchWallets();
      _calculateTotalBalance();
      errorMessage = '';
    } catch (e) {
      errorMessage = 'Erreur lors de la récupération des portefeuilles: $e';
    }
    notifyListeners();
  }

  /// Fonction pour récupérer les transactions récentes
  Future<void> fetchRecentTransactions() async {
    try {
      recentTransactions = await walletRepository.fetchRecentTransactions();
      errorMessage = '';
    } catch (e) {
      errorMessage = 'Erreur lors de la récupération des transactions récentes: $e';
    }
    notifyListeners();
  }

  /// Fonction pour calculer le total des soldes des portefeuilles
  void _calculateTotalBalance() {
    totalBalance = wallets.fold(0.0, (sum, wallet) => sum + wallet.balance);
  }

  /// Met à jour la requête de recherche et filtre les portefeuilles
  void setSearchQuery(String query) {
    _searchQuery = query;
    _filterWallets();
    notifyListeners();
  }

  /// Filtrage des portefeuilles en fonction de la recherche
  void _filterWallets() {
    if (_searchQuery.isEmpty) {
      fetchWallets(); // Recharger tous les portefeuilles si aucune recherche
    } else {
      // Filtrer les portefeuilles
      wallets = wallets
          .where((wallet) =>
              wallet.walletName.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notifier les changements après le filtrage
  }
}