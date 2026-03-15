import 'package:fpv_fic/domain/repository/fondos_repository.dart';

class CancelSuscriptionUseCase {
  final FondosRepository repository;
  CancelSuscriptionUseCase(this.repository);

  Future<void> call(String idFondo) async {
    try {
      await repository.unsuscribeFondo(idFondo);
    } catch (e) {
      throw Exception('Error al cancelar la suscripción: $e');
    }
  }
}
