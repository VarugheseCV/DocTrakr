// lib/services/auth_service.dart

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  String _userEmail = '';
  String _userMobile = '';

  bool get isAuthenticated => _isAuthenticated;
  String get userEmail => _userEmail;
  String get userMobile => _userMobile;

  // Google Sign-In
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService() {
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _userEmail = prefs.getString('userEmail') ?? '';
    _userMobile = prefs.getString('userMobile') ?? '';
    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password) async {
    // For demonstration, we'll accept any email/password.
    // Implement proper authentication in production.
    _isAuthenticated = true;
    _userEmail = email;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);
    await prefs.setString('userEmail', email);
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        _isAuthenticated = true;
        _userEmail = account.email;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isAuthenticated', true);
        await prefs.setString('userEmail', _userEmail);
        notifyListeners();
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  Future<void> signInWithMobile(String mobileNumber) async {
    // For demonstration, we'll accept any mobile number.
    // Implement proper verification in production.
    _isAuthenticated = true;
    _userMobile = mobileNumber;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);
    await prefs.setString('userMobile', mobileNumber);
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userEmail = '';
    _userMobile = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    await prefs.remove('userEmail');
    await prefs.remove('userMobile');
    notifyListeners();
  }
}
