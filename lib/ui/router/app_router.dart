import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/pages/home.dart';
import 'package:fpv_fic/ui/pages/login.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:go_router/go_router.dart';

final routerNotifierProvider = NotifierProvider<RouterNotifier, void>(
  RouterNotifier.new,
);

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
    final isAuthenticated = ref.read(authControllerProvider).isAuthenticated;
    final isLoginPage = routerState.matchedLocation == '/login';

    if (!isAuthenticated && !isLoginPage) return '/login';
    if (isAuthenticated && isLoginPage) return '/home';
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
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
});
