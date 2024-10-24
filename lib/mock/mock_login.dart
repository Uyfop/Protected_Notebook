import 'package:shared_preferences/shared_preferences.dart';

const List<Map<String, String>> defaultUsers = [
  {
    'username': 'user1',
    'password': 'user1',
    'message': 'Welcome to Secure Notebook, user1!',
  },
  {
    'username': 'user2',
    'password': 'user2',
    'message': 'Welcome to Secure Notebook, user2!',
  },
];

Future<void> initializeDefaultUsers() async {
  final prefs = await SharedPreferences.getInstance();

  for (var user in defaultUsers) {
    String? storedPassword = prefs.getString('${user['username']}_password');

    if (storedPassword == null) {
      await prefs.setString('${user['username']}_password', user['password']!);
      await prefs.setString('${user['username']}_message', user['message']!);
    }
  }
}