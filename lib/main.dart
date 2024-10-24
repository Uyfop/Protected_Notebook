import 'package:flutter/material.dart';
import 'package:notebook_protected/pages/login_page.dart';
import 'mock/mock_login.dart';

void main() {
  runApp(const MyApp());
  initializeDefaultUsers();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protected Notebook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}



