import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fpv_fic/data/repository/fonfos_repository_imp.dart';
import 'package:fpv_fic/domain/repository/fondos_repository.dart';
import 'package:fpv_fic/ui/controllers/founds_controller.dart';

final foundsRepositoryProvider = Provider<FondosRepository>(
  (ref) => FondosRepositoryImp(),
);

final foundsControllerProvider =
    StateNotifierProvider<FoundsController, FoundsState>(
      (ref) => FoundsController(
        foundsRepository: ref.watch(foundsRepositoryProvider),
        ref: ref,
      ),
    );
