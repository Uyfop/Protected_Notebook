import 'package:flutter/material.dart';
import '../secure_notebook.dart';

class NotebookPage extends StatefulWidget {
  final SecureNotebook notebook;
  final Map<String, String> user;
  final String message;

  const NotebookPage(
      {
        super.key,
        required this.notebook,
        required this.message,
        required this.user
      });

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String _successMessage = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _messageController.text = widget.message;
  }

  void _saveMessage() {
    try {
      widget.notebook.setMessage(widget.user['username']!, widget.user['password']!, _messageController.text);
      setState(() {
        _successMessage = 'Message saved';
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: saving message failed';
        _successMessage = '';
      });
    }
  }

  void _changePassword() {
    try {
      widget.notebook.changePassword(
          _oldPasswordController.text, _newPasswordController.text);
      setState(() {
        _successMessage = 'Password saved';
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: saving password failed';
        _successMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protected Notebook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Message:'),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMessage,
              child: const Text('Save message'),
            ),
            const SizedBox(height: 20),
            const Text('Change Password:'),
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Zmień hasło'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (_successMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _successMessage,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}