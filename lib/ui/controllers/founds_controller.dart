import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/enity/transaction.dart';
import 'package:fpv_fic/domain/repository/fondos_repository.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';

class FoundsState {
  final List<FondoModel> fondos;
  final List<FondoModel> suscritos;
  final List<TransaccionModel> historial;
  final bool isLoading;
  final String? error;

  FoundsState({
    required this.fondos,
    required this.suscritos,
    required this.historial,
    this.isLoading = false,
    this.error,
  });

  FoundsState copyWith({
    List<FondoModel>? fondos,
    List<FondoModel>? suscritos,
    List<TransaccionModel>? historial,
    bool? isLoading,
    String? error,
  }) {
    return FoundsState(
      fondos: fondos ?? this.fondos,
      suscritos: suscritos ?? this.suscritos,
      historial: historial ?? this.historial,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// ─── Controller ───────────────────────────────────────────
class FoundsController extends StateNotifier<FoundsState> {
  final FondosRepository _foundsRepository;
  final Ref _ref; //

  FoundsController({
    required FondosRepository foundsRepository,
    required Ref ref,
  }) : _foundsRepository = foundsRepository,
       _ref = ref,
       super(FoundsState(fondos: [], suscritos: [], historial: []));

  Future<void> loadFounds() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final fondos = await _foundsRepository.getFondos();
      state = state.copyWith(fondos: fondos, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> suscribeFondo(
    FondoModel fondo,
    MetodoNotificacion metodo,
    double monto,
  ) async {
    try {
      final usuario = _ref.read(authControllerProvider).usuario;
      if (usuario.saldo <= 0) {
        state = state.copyWith(error: 'Saldo insuficiente para suscribirse');
        return;
      }
      await _foundsRepository.suscribeFondo(fondo.id.toString(), metodo);
      await _ref.read(authControllerProvider.notifier).updateSaldo(-monto);
      logger.log(
        "FoundsController: suscribeFondo() llamado, monto descontado: $monto",
      );

      final transaccion = TransaccionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fondoId: fondo.id,
        nombreFondo: fondo.nombre,
        categoriaFondo: CategoriaFondo.values.firstWhere(
          (cat) => cat.value == fondo.categoria,
          orElse: () => CategoriaFondo.fvp,
        ),
        monto: monto,
        tipo: TipoTransaccion.suscripcion,
        metodo: metodo,
        fecha: DateTime.now(),
      );

      // Simular Historial
      state = state.copyWith(historial: [transaccion, ...state.historial]);
      // Agregar a suscritos
      state = state.copyWith(suscritos: [fondo, ...state.suscritos]);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> unsubscribeFondo(String trasactionId) async {
    try {
      await _foundsRepository.unsuscribeFondo(trasactionId);
      // buscar la transacción en el historial para obtener el monto y devolverlo al usuario
      // cambiar el estado de suscrito a no suscrito
      final transaccion = state.historial.firstWhere(
        (t) =>
            t.id.toString() == trasactionId &&
            t.tipo == TipoTransaccion.suscripcion,
        orElse: () => throw Exception('Transacción no encontrada'),
      );

      await _ref
          .read(authControllerProvider.notifier)
          .updateSaldo(transaccion.monto);
      logger.log(
        "FoundsController: unsubscribeFondo() llamado, monto devuelto: ${transaccion.monto}",
      );

      state = state.copyWith(
        suscritos: state.suscritos
            .where((f) => f.id.toString() != trasactionId)
            .toList(),
        historial: state.historial.map((t) {
          if (t.id.toString() == trasactionId) {
            return t.copyWith(tipo: TipoTransaccion.cancelacion);
          }
          return t;
        }).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
