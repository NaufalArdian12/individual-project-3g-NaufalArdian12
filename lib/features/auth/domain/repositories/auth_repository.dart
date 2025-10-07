import '../models/user.dart';

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<String?> register(User user); // null jika sukses, string pesan error jika gagal
  Future<void> logout();
  Future<String?> getLoggedInUsername(); // dari sesi
}
