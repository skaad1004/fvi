import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/pages/home.dart';
import 'package:fpv_fic/ui/pages/login.dart';
import 'package:fpv_fic/ui/pages/splash.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:go_router/go_router.dart';

final routerNotifierProvider = NotifierProvider<RouterNotifier, void>(
  RouterNotifier.new,
);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouterNotifier extends Notifier<void> implements Listenable {
  final List<VoidCallback> _listeners = [];

  @override
  void build() {
    // Cada vez que authState cambia, notifica al GoRouter
    ref.listen(authControllerProvider, (_, __) {
      for (final listener in _listeners) {
        listener();
      }
    });
  }

  String? redirect(BuildContext context, GoRouterState routerState) {
    // final isAuthenticated = ref.read(authControllerProvider).isAuthenticated;
    final authState = ref.read(authControllerProvider);
    final isAuthenticated = authState.isAuthenticated;
    final location = routerState.matchedLocation;

    if (!isAuthenticated && location != '/login') return '/login';

    if (isAuthenticated && (location == '/login' || location == '/')) {
      return '/home';
    }

    return null;
  }

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.read(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          name: 'Login - BTG',
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          name: 'Home - BTG',
          child: const HomePage(),
        ),
      ),
    ],
  );
});
