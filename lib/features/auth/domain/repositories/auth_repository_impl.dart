import 'package:pemrograman_mobile/features/auth/data/datasources/session_local_data_source.dart';

import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SessionLocalDataSource session;
  AuthRepositoryImpl(this.session);

  @override
  Future<bool> login(String username, String password) async {
    final match = userList.any((u) => u.username == username && u.password == password);
    if (match) await session.saveLoggedIn(username);
    return match;
  }

  @override
  Future<String?> register(User user) async {
    final exists = userList.any((u) => u.username == user.username || u.email == user.email);
    if (exists) return 'Username/email sudah dipakai';
    userList.add(user);
    return null;
  }

  @override
  Future<void> logout() => session.clear();

  @override
  Future<String?> getLoggedInUsername() => session.getLoggedIn();
}
