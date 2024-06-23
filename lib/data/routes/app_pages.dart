import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/ui/screens/base/base_screen.dart';
import 'package:lojavirtualapp/ui/screens/login/login_screen.dart';
import 'package:lojavirtualapp/ui/screens/register/register_screen.dart';

final routerConfig = GoRouter(
  initialLocation: AppRoutes.base,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.base,
      builder: (context, state) => const BaseScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
