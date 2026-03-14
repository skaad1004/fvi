import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fpv_fic/data/repository/auth_repository_imp.dart';
import 'package:fpv_fic/data/repository/session_repository_imp.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';
import 'package:fpv_fic/domain/repository/sesion_repository.dart';
import 'package:fpv_fic/domain/use_case/auth/login_user_use_case.dart';
import 'package:fpv_fic/domain/use_case/auth/logout_use_case.dart';
import 'package:fpv_fic/ui/controllers/auth_controller.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImp(),
);

final loginUseCaseProvider = Provider<LoginUserUseCase>(
  (ref) => LoginUserUseCase(ref.read(authRepositoryProvider)),
);

final logoutUseCaseProvider = Provider<LogoutUserUseCase>(
  (ref) => LogoutUserUseCase(ref.read(authRepositoryProvider)),
);

final sesionRepositoryProvider = Provider<SesionRepository>(
  (ref) => SessionRepositoryImp(),
);

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    loginUseCase: ref.read(loginUseCaseProvider),
    logoutUseCase: ref.read(logoutUseCaseProvider),
    authRepository: ref.read(authRepositoryProvider),
    sessionRepository: ref.read(sesionRepositoryProvider),
  ),
);
