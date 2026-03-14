import 'package:fpv_fic/domain/repository/app_info_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoControllerImp implements AppInfoRepository {
  @override
  Future<String> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }
}
