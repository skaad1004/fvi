abstract class SesionRepository {
  Future<void> saveSession(String userId);
  Future<String?> getSession();
  Future<void> clearSession();
}
