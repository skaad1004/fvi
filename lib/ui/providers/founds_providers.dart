import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fpv_fic/data/repository/auth_repository_imp.dart';
import 'package:fpv_fic/data/repository/fonfos_repository_imp.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';
import 'package:fpv_fic/domain/repository/fondos_repository.dart';
import 'package:fpv_fic/domain/use_case/fondos/get_fondos_use_case.dart';
import 'package:fpv_fic/ui/controllers/founds_controller.dart';

final foundsRepositoryProvider = Provider<FondosRepository>(
  (ref) => FondosRepositoryImp(),
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImp(),
);

final getFoundsUseCaseProvider = Provider<GetFondosUseCase>(
  (ref) => GetFondosUseCase(ref.watch(foundsRepositoryProvider)),
);

final foundsControllerProvider =
    StateNotifierProvider<FoundsController, FoundsState>(
      (ref) => FoundsController(
        authRepository: ref.watch(authRepositoryProvider),
        foundsRepository: ref.watch(getFoundsUseCaseProvider),
      ),
    );
