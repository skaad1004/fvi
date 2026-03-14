import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';

class LogoutUserUseCase {
  final AuthRepository _repository;

  LogoutUserUseCase(this._repository);

  void call() {
    try {
      _repository.logout();
    } catch (e) {
      logger.logError('Error en LogoutUserUseCase: $e');
    }
  }
}
