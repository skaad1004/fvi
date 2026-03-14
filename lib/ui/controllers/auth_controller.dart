import 'package:flutter_riverpod/legacy.dart';
import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/data/repository/session_repository_imp.dart';
import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';
import 'package:fpv_fic/domain/repository/sesion_repository.dart';
import 'package:fpv_fic/domain/use_case/auth/login_user_use_case.dart';
import 'package:fpv_fic/domain/use_case/auth/logout_use_case.dart';

class AuthState {
  final UsuarioModel usuario;
  final bool isLoading;
  final String error;
  final bool isRestoring;

  const AuthState({
    required this.usuario,
    this.isLoading = false,
    this.isRestoring = false,
    this.error = '',
  });

  bool get isAuthenticated => usuario.id.isNotEmpty;

  AuthState copyWith({
    UsuarioModel? usuario,
    bool? isLoading,
    String? error,
    bool? isRestoring,
  }) => AuthState(
    usuario: usuario ?? this.usuario,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    isRestoring: isRestoring ?? this.isRestoring,
  );
}

// ─── Controller ───────────────────────────────────────────
class AuthController extends StateNotifier<AuthState> {
  final LoginUserUseCase _loginUseCase;
  final LogoutUserUseCase _logoutUseCase;
  final AuthRepository _authRepository;
  final SesionRepository _sessionRepository;

  AuthController({
    required LoginUserUseCase loginUseCase,
    required LogoutUserUseCase logoutUseCase,
    required AuthRepository authRepository,
    required SesionRepository sessionRepository,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _authRepository = authRepository,
       _sessionRepository = sessionRepository,
       super(AuthState(usuario: UsuarioModel.empty()));

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: '');

    try {
      final (usuario, error) = await _loginUseCase(email, password);

      if (error != null) {
        state = state.copyWith(error: error, isLoading: false);
        return;
      }
      await _sessionRepository.saveSession(usuario.id);
      state = state.copyWith(
        usuario: usuario,
        error: error ?? '',
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error al iniciar sesión',
        isLoading: false,
      );
    }
  }

  Future<void> logout() async {
    _logoutUseCase();
    await _sessionRepository.clearSession();
    state = AuthState(usuario: UsuarioModel.empty());
  }

  // Restaura sesión al hacer refresh
  Future<void> restoreSession() async {
    final userId = await _sessionRepository.getSession();
    if (userId == null) return;

    final usuario = _authRepository.getUsuarioById(userId);
    state = state.copyWith(usuario: usuario);
    if (usuario.id.isNotEmpty) {
      state = state.copyWith(usuario: usuario);
      logger.log('✅ Sesión restaurada para usuario: ${usuario.email}');
      return;
    }

    await _sessionRepository.clearSession();
    state = state.copyWith(isRestoring: false);
  }
}
