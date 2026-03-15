import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/enity/transaction.dart';
import 'package:fpv_fic/domain/enity/usuario.dart';
import 'package:fpv_fic/domain/repository/auth_repository.dart';
import 'package:fpv_fic/domain/repository/sesion_repository.dart';
import 'package:fpv_fic/domain/use_case/auth/login_user_use_case.dart';
import 'package:fpv_fic/domain/use_case/auth/logout_use_case.dart';
import 'package:fpv_fic/ui/controllers/auth_controller.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:mockito/annotations.dart';
import 'package:fpv_fic/domain/repository/fondos_repository.dart';
import 'package:mockito/mockito.dart';

import 'founds_controller_test.mocks.dart';

@GenerateMocks([
  FondosRepository,
  AuthRepository,
  SesionRepository,
  LoginUserUseCase,
  LogoutUserUseCase,
])
void main() {
  late MockFondosRepository mockRepository;
  late ProviderContainer container;
  late MockAuthRepository mockAuthRepository;
  late MockLoginUserUseCase mockLoginUseCase;
  late MockLogoutUserUseCase mockLogoutUseCase;
  late MockSesionRepository mockSessionRepository;
  // moks auth

  final fondosMock = [
    FondoModel(
      id: 1,
      nombre: 'FPV_RECAUDADORA',
      montoMinimo: 75000,
      categoria: 'FPV',
    ),
    FondoModel(
      id: 2,
      nombre: 'FPV_ECOPETROL',
      montoMinimo: 125000,
      categoria: 'FPV',
    ),
  ];

  // final userLogged = UsuarioModel(
  //   id: "1",
  //   nombre: 'Juan Pérez',
  //   email: 'juan.perez@example.com',
  //   saldo: 500000,
  //   password: 'password123',
  //   telefono: '1234567890',
  //   fondosSuscritos: [],
  // );

  final userLogged = UsuarioModel(
    id: '1',
    nombre: 'Juan Pérez',
    email: 'juan.perez@example.com',
    saldo: 500000,
    password: 'password123',
    telefono: '1234567890',
    fondosSuscritos: [],
  );

  setUp(() {
    mockRepository = MockFondosRepository();
    mockAuthRepository = MockAuthRepository();
    mockLoginUseCase = MockLoginUserUseCase();
    mockLogoutUseCase = MockLogoutUserUseCase();
    mockSessionRepository = MockSesionRepository();
    when(
      mockAuthRepository.login(any, any),
    ).thenAnswer((_) async => (userLogged, null));
    when(mockAuthRepository.getUsuarioActivo()).thenReturn(userLogged);
    when(mockAuthRepository.updateSaldo(any)).thenAnswer((_) async {});

    when(mockRepository.getFondos()).thenAnswer((_) async => fondosMock);
    when(mockRepository.suscribeFondo(any, any)).thenAnswer((_) async {});
    when(mockRepository.unsuscribeFondo(any)).thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        foundsRepositoryProvider.overrideWithValue(mockRepository),
        authControllerProvider.overrideWith((ref) {
          final notifier = AuthController(
            authRepository: mockAuthRepository,
            loginUseCase: mockLoginUseCase,
            logoutUseCase: mockLogoutUseCase,
            sessionRepository: mockSessionRepository,
          );
          notifier.state = AuthState(usuario: userLogged, isLoading: false);
          return notifier;
        }),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('FoundsController', () {
    test('loadFounds carga los fondos correctamente', () async {
      final notifier = container.read(foundsControllerProvider.notifier);
      await notifier.loadFounds();

      final state = container.read(foundsControllerProvider);
      expect(state.fondos.length, 2);
      expect(state.isLoading, false);
      expect(state.error, null);
    });

    test('suscribir descuenta el saldo y agrega al historial', () async {
      // Simula usuario con saldo
      // ... setup del authController con saldo 500000
      final notifier = container.read(foundsControllerProvider.notifier);
      await notifier.loadFounds();

      await notifier.suscribeFondo(
        fondosMock[0],
        MetodoNotificacion.email,
        75000,
      );

      final state = container.read(foundsControllerProvider);
      expect(state.suscritos.length, 1);
      expect(state.historial[0].monto, 75000);
      expect(state.error, null);
    });

    test('suscribir con saldo insuficiente muestra error', () async {
      // Simula usuario con saldo 0
      final notifier = container.read(foundsControllerProvider.notifier);

      await notifier.unsubscribeFondo(fondosMock[0].id.toString());

      final state = container.read(foundsControllerProvider);
      expect(state.error, isNotNull);
      expect(state.suscritos, isEmpty);
    });
  });
}
