import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/enity/transaction.dart';

abstract class FondosRepository {
  Future<List<FondoModel>> getFondos();
  Future<void> suscribeFondo(String fondoId, MetodoNotificacion metodo);
  Future<void> unsuscribeFondo(String fondoId);
  Future<List<TransaccionModel>> getTransactions(String fondoId);
}
