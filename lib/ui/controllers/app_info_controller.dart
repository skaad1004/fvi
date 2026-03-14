import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/data/repository/app_info_controller_imp.dart';
import 'package:fpv_fic/domain/use_case/settings/get_version_app_use_case.dart';

final appInfoRepositoryProvider = Provider((_) => AppInfoControllerImp());

final getAppVersionUseCaseProvider = Provider((ref) {
  final repo = ref.read(appInfoRepositoryProvider);
  return GetVersionAppUseCase(repo);
});

final appVersionProvider = FutureProvider<String>((ref) async {
  final useCase = ref.read(getAppVersionUseCaseProvider);
  return useCase();
});
