const List<Map<String, String>> users = [
  {
    'username': 'user1',
    'password': 'user1',
    'message': '',
    'token': 'user1token',
  },
  {
    'username': 'user2',
    'password': 'user2',
    'message': '',
    'token': 'user2token',
  },
];

List<Map<String, String>> activeUsers = [];

void initializeActiveUsers() {
  activeUsers = List.from(users.map((user) => Map<String, String>.from(user)));
}