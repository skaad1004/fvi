import 'package:fpv_fic/domain/enity/usuario.dart';

abstract class AuthRepository {
  UsuarioModel login(String email, String password);
  void logout();
  UsuarioModel getUsuarioActivo();
}
