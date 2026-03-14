import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository _repository;

  LoginUserUseCase(this._repository);

  Future<(UsuarioModel, String?)> call(String email, String password) async {
    try {
      return await _repository.login(email, password);
    } catch (e) {
      logger.logError('Error en LoginUserUseCase: $e');
      return (UsuarioModel.empty(), 'Error al iniciar sesión');
    }
  }
}
