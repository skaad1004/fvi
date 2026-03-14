import 'package:fpv_fic/data/mock_data.dart';
import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<(UsuarioModel, String?)> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    final usuario = usuariosMock
        .where((u) => u.email == email && u.password == password)
        .firstOrNull;

    if (usuario != null) {
      return (usuario, null);
    }

    return (UsuarioModel.empty(), 'Email o contraseña incorrectos');
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
