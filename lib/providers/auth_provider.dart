import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _token;
  String get _baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080';

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
        // You can add a call to verify token with backend here
        // For now, we'll create a mock user when token exists
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
      final url = Uri.parse('$_baseUrl/auth/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == HttpStatus.created) {
        final responseData = jsonDecode(response.body);
        debugPrint('Login successful: $responseData');

        // Extract data from the nested structure
        final data = responseData['data'];
        final token = data['token'] as String;
        final isHave2fa = data['isHave2fa'] as bool;
        final isFirstTime = data['isFirstTime'] as bool;

        _token = token;

        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        // Create user object (you might want to fetch user details from another endpoint)
        _user = User(
          id: '1',
          name: 'User', // You can get this from another API call
          email: email,
          position: 'Employee',
          department: 'Department',
        );

        _isLoading = false;
        notifyListeners();

        // Note: isHave2fa and isFirstTime can be used for additional logic later
        debugPrint(
          'Login successful. 2FA required: $isHave2fa, First time: $isFirstTime',
        );

        return true;
      } else {
        debugPrint('Login failed: ${response.statusCode} - ${response.body}');
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
