import 'package:fpv_fic/domain/enity/usuario.dart';

abstract class AuthRepository {
  Future<(UsuarioModel, String?)> login(String email, String password);
  void logout();
  UsuarioModel getUsuarioActivo();
  UsuarioModel getUsuarioById(String id);
  Future<void> updateSaldo(double d);
}
