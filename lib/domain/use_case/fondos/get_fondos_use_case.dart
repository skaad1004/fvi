import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/repository/fondos_repository.dart';

class GetFondosUseCase {
  final FondosRepository repository;

  GetFondosUseCase(this.repository);

  Future<List<FondoModel>> call() async {
    try {
      return await repository.getFondos();
    } catch (e) {
      throw Exception('Error al obtener los fondos: $e');
    }
  }
}
