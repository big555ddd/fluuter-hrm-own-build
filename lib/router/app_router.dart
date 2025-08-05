import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final isAuthenticated = authProvider.isAuthenticated;
        final isLoading = authProvider.isLoading;

        // If still loading, don't redirect yet
        if (isLoading) return null;

        // If not authenticated and not on login page, redirect to login
        if (!isAuthenticated && state.matchedLocation != '/login') {
          return '/login';
        }

        // If authenticated and on login page, redirect to dashboard
        if (isAuthenticated && state.matchedLocation == '/login') {
          return '/';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    );
  }
}
