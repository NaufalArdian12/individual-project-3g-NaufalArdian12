import 'package:shared_preferences/shared_preferences.dart';

class SessionLocalDataSource {
  static const kLoggedInUser = 'loggedInUser';

  Future<void> saveLoggedIn(String username) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(kLoggedInUser, username);
  }

  Future<String?> getLoggedIn() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(kLoggedInUser);
  }

  Future<void> clear() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(kLoggedInUser);
  }
}
