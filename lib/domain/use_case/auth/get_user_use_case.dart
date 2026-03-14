import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository _repository;
  GetUserUseCase(this._repository);
  UsuarioModel call() {
    return _repository.getUsuarioActivo();
  }
}
