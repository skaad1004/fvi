import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  @override
  UsuarioModel login(String email, String password) {
    return UsuarioModel.empty();
  }

  @override
  void logout() {
    // Implementa la lógica de cierre de sesión aquí
    // Por ejemplo, puedes limpiar los datos del usuario activo o cerrar la sesión en el servicio de autenticación
  }

  @override
  UsuarioModel getUsuarioActivo() {
    return UsuarioModel.empty();
  }
}
