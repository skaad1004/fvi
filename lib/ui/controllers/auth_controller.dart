import 'package:flutter_riverpod/legacy.dart';
import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/use_case/auth/login_user_use_case.dart';
import 'package:fpv_fic/domain/use_case/auth/logout_use_case.dart';

class AuthState {
  final UsuarioModel usuario;
  final bool isLoading;
  final String error;

  const AuthState({
    required this.usuario,
    this.isLoading = false,
    this.error = '',
  });

  bool get isAuthenticated => usuario.id.isNotEmpty;

  AuthState copyWith({UsuarioModel? usuario, bool? isLoading, String? error}) =>
      AuthState(
        usuario: usuario ?? this.usuario,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
}

// ─── Controller ───────────────────────────────────────────
class AuthController extends StateNotifier<AuthState> {
  final LoginUserUseCase _loginUseCase;
  final LogoutUserUseCase _logoutUseCase;

  AuthController({
    required LoginUserUseCase loginUseCase,
    required LogoutUserUseCase logoutUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       super(AuthState(usuario: UsuarioModel.empty()));

  void login(String email, String password) {
    state = state.copyWith(isLoading: true, error: '');

    try {
      final usuario = _loginUseCase(email, password);
      state = state.copyWith(usuario: usuario, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Error al iniciar sesión',
        isLoading: false,
      );
    }
  }

  void logout() {
    _logoutUseCase();
    state = AuthState(usuario: UsuarioModel.empty());
  }
}
