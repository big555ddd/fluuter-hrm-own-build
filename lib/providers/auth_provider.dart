import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _token;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null && _user != null;
  String? get token => _token;

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');

      if (_token != null) {
        // Mock user data - in real app, you'd fetch from API
        _user = const User(
          id: '1',
          name: 'John Doe',
          email: 'john.doe@company.com',
          position: 'Software Developer',
          department: 'IT Department',
        );
      }
    } catch (e) {
      debugPrint('Error checking auth status: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Mock login - replace with actual API call
      await Future.delayed(const Duration(seconds: 2));

      if (email == 'admin@company.com' && password == 'password') {
        _token = 'mock_token_123456';
        _user = const User(
          id: '1',
          name: 'Admin User',
          email: 'admin@company.com',
          position: 'HR Manager',
          department: 'Human Resources',
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);

        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      _token = null;
      _user = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }
}
