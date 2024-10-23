class SecureNotebook {
  Map<String, String> user;
  String _passwordHash;

  SecureNotebook(this.user)
      : _passwordHash = _hashPassword(user['password']!);

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

  void setMessage(String username, String password, String newMessage) {
    if (verifyUsername(username) && verifyPassword(password)) {
      user['message'] = newMessage;
    } else {
      throw Exception('Wrong password or Username');
    }
  }

  void changePassword(String oldPassword, String newPassword) {
    if (verifyPassword(oldPassword)) {
      _passwordHash = _hashPassword(newPassword);
      user['password'] = newPassword;
    } else {
      throw Exception('Wrong Password');
    }
  }
}
