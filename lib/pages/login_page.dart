import 'package:flutter/material.dart';
import '../mock/mock_login.dart';
import '../secure_notebook.dart';
import 'notebook_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

  }

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty) {
      setState(() {
        _errorMessage = 'Username can\'t be empty';
      });
      return;
    }

    final user = await SecureNotebook.loadFromSharedPreferences(username);

    if (user != null && SecureNotebook(user).verifyPassword(password)) {
      SecureNotebook notebook = SecureNotebook(user);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotebookPage(
            notebook: notebook,
            user: user,
            message: notebook.getMessage(username, password),
          ),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Wrong Username or Password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),

          ],
        ),
      ),
    );
  }
}