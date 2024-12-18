// user_view_model.dart
import 'package:flutter/foundation.dart';
import 'package:brichbackoffice/data/entities/user.dart';
import 'package:brichbackoffice/data/entities/wallet.dart';
import 'package:brichbackoffice/data/repositories/WalletRepository.dart';
import 'package:brichbackoffice/ui/user/userService.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  final WalletRepository? walletRepository;

  List<User> _users = [];
  User? _selectedUser;
  List<Wallet>? _userWallets;
  bool _isLoading = false;
  String? _error;

  UserViewModel([this.walletRepository]);

  // Getters
  List<User> get users => _users;
  User? get selectedUser => _selectedUser;
  List<Wallet>? get userWallets => _userWallets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch Users
  Future<void> fetchUsers() async {
    _setLoading(true);
    try {
      _users = await _userService.fetchUsers();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Fetch User Details
  Future<void> fetchUserDetails(String userId) async {
    _setLoading(true);
    try {
      _selectedUser = await _userService.fetchUserById(userId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Fetch User Wallets
  Future<void> fetchUserWallets(String userId) async {
    _setLoading(true);
    try {
      _userWallets = await _userService.getUserWallets(userId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Fetch All Wallets
  Future<void> fetchWallets() async {
    _setLoading(true);
    try {
      _userWallets = await _userService.fetchWallets();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Helper method to handle loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}