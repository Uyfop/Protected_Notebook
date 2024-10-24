import 'package:shared_preferences/shared_preferences.dart';

class SecureNotebook {
  Map<String, String> user;
  String _passwordHash;

  SecureNotebook(this.user)
      : _passwordHash = _hashPassword(user['password']!);

  static Future<void> saveToSharedPreferences(Map<String, String> user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('${user['username']}_password', user['password']!);
    prefs.setString('${user['username']}_message', user['message'] ?? '');
  }

  static Future<Map<String, String>?> loadFromSharedPreferences(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final password = prefs.getString('${username}_password');
    final message = prefs.getString('${username}_message');
    if (password != null) {
      return {
        'username': username,
        'password': password,
        'message': message ?? '',
      };
    }
    return null;
  }

  static String _hashPassword(String password) {
    return password.hashCode.toString();
  }

  bool verifyPassword(String password) {
    return _passwordHash == _hashPassword(password);
  }

  bool verifyUsername(String username){
    return user['username'] == username;
  }

  String getMessage(String username, String password) {
    if (verifyUsername(username) && verifyPassword(password)) {
      return user['message'] ?? '';
    } else {
      throw Exception('Wrong password or Username');
    }
  }

  Future<void> setMessage(String username, String password, String newMessage) async {
    if (verifyUsername(username) && verifyPassword(password)) {
      user['message'] = newMessage;
      await saveToSharedPreferences(user);
    } else {
      throw Exception('Wrong password or Username');
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    if (verifyPassword(oldPassword)) {
      _passwordHash = _hashPassword(newPassword);
      user['password'] = newPassword;
      await saveToSharedPreferences(user);
    } else {
      throw Exception('Wrong Password');
    }
  }
}
