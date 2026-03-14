import 'package:fpv_fic/domain/repository/sesion_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepositoryImp implements SesionRepository {
  static const _keyUserId = 'session_user_id';
  @override
  Future<void> saveSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
  }

  @override
  Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  @override
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }
}
