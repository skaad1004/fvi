import 'package:fpv_fic/data/mock_data.dart';
import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/enity/transaction.dart';
import 'package:fpv_fic/domain/repository/fondos_repository.dart';

class FondosRepositoryImp implements FondosRepository {
  @override
  Future<List<FondoModel>> getFondos() async {
    await Future.delayed(const Duration(seconds: 1));
    return fondosMock;
  }

  @override
  Future<List<TransaccionModel>> getTransactions(String fondoId) {
    throw UnimplementedError();
  }

  @override
  Future<void> suscribeFondo(String fondoId, MetodoNotificacion metodo) {
    throw UnimplementedError();
  }

  @override
  Future<void> unsuscribeFondo(String fondoId) {
    throw UnimplementedError();
  }
}
