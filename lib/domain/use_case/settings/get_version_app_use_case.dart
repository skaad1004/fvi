import 'package:fpv_fic/domain/repository/app_info_repository.dart';

class GetVersionAppUseCase {
  final AppInfoRepository _appInfoRepository;

  GetVersionAppUseCase(this._appInfoRepository);

  Future<String> call() async {
    return await _appInfoRepository.getAppVersion();
  }
}
