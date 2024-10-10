// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctrakr/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailFormKey = GlobalKey<FormState>();
  final _mobileFormKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _mobileNumber = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        // Added to prevent overflow
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email Login
            Form(
              key: _emailFormKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (value) {
                      _email = value ?? '';
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _submitEmailLogin(authService);
                    },
                    child: Text('Login with Email'),
                  ),
                ],
              ),
            ),
            Divider(),
            // Google Login
            ElevatedButton.icon(
              icon: Icon(Icons.login),
              label: Text('Login with Google'),
              onPressed: () {
                authService.signInWithGoogle();
              },
            ),
            Divider(),
            // Mobile Number Login
            Form(
              key: _mobileFormKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      _mobileNumber = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter a valid mobile number.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _submitMobileLogin(authService);
                    },
                    child: Text('Login with Mobile Number'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitEmailLogin(AuthService authService) {
    if (_emailFormKey.currentState?.validate() ?? false) {
      _emailFormKey.currentState?.save();
      authService.signInWithEmail(_email, _password);
    }
  }

  void _submitMobileLogin(AuthService authService) {
    if (_mobileFormKey.currentState?.validate() ?? false) {
      _mobileFormKey.currentState?.save();
      authService.signInWithMobile(_mobileNumber);
    }
  }
}
