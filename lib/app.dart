// lib/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctrakr/services/auth_service.dart';
import 'package:doctrakr/services/document_service.dart';
import 'package:doctrakr/screens/login_screen.dart';
import 'package:doctrakr/screens/home_screen.dart';

class DocumentDeadlineTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<DocumentService>(
          create: (_) => DocumentService(),
        ),
      ],
      child: MaterialApp(
        title: 'Document Deadline Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthService>(
          builder: (context, authService, _) {
            if (authService.isAuthenticated) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
        routes: {
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          // Add other routes here
        },
      ),
    );
  }
}
