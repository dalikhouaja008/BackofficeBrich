import 'package:brichbackoffice/ui/user/userService.dart';
import 'package:flutter/foundation.dart';
import 'package:brichbackoffice/data/entities/user.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();

  List<User> _users = [];
  User? _selectedUser;
  List<dynamic>? _userWallets;
  bool _isLoading = false;
  String? _error;

  List<User> get users => _users;
  User? get selectedUser => _selectedUser;
  List<dynamic>? get userWallets => _userWallets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _userService.fetchUsers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserDetails(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedUser = await _userService.fetchUserById(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserWallets(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userWallets = await _userService.fetchUserWallets(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
