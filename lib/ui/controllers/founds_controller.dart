import 'package:flutter_riverpod/legacy.dart';
import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/enity/transaction.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';
import 'package:fpv_fic/domain/repository/fondos_repository.dart';
import 'package:fpv_fic/domain/use_case/fondos/get_fondos_use_case.dart';

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
  final AuthRepository _authRepository;
  final GetFondosUseCase _foundsRepository;

  FoundsController({
    required AuthRepository authRepository,
    required GetFondosUseCase foundsRepository,
  }) : _authRepository = authRepository,
       _foundsRepository = foundsRepository,
       super(FoundsState(fondos: [], suscritos: [], historial: []));

  Future<void> loadFounds() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final fondos = await _foundsRepository();
      state = state.copyWith(fondos: fondos, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
