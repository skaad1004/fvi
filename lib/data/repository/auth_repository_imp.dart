import 'package:fpv_fic/data/mock_data.dart';
import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  UsuarioModel? _usuarioActivo;
  @override
  Future<(UsuarioModel, String?)> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    final usuario = usuariosMock
        .where((u) => u.email == email && u.password == password)
        .firstOrNull;

    if (usuario != null) {
      _usuarioActivo = usuario;
      return (usuario, null);
    }

    return (UsuarioModel.empty(), 'Email o contraseña incorrectos');
  }

  @override
  void logout() {
    _usuarioActivo = null;
  }

  @override
  UsuarioModel getUsuarioActivo() {
    return _usuarioActivo ?? UsuarioModel.empty();
  }

  @override
  UsuarioModel getUsuarioById(String id) {
    final usuario = usuariosMock.where((u) => u.id == id).firstOrNull;
    if (usuario != null) {
      _usuarioActivo = usuario;
    }
    return usuario ?? UsuarioModel.empty();
  }

  @override
  Future<void> updateSaldo(double monto) async {
    await Future.delayed(const Duration(seconds: 1));
    final usuario = getUsuarioActivo();
    _usuarioActivo = usuario.copyWith(saldo: usuario.saldo + monto);
  }
}
