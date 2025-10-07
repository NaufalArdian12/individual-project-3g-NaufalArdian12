class User {
  final String fullname;
  final String email;
  final String username;
  final String password; // hanya untuk dummy praktikum

  const User({
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
  });
}

// Dummy list buat praktikum
final List<User> userList = [
  const User(
    fullname: 'User Dummy',
    email: 'user1@example.com',
    username: 'user1',
    password: 'password1',
  ),
];
