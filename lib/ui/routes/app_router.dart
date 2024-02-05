import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';
import '../pages/search_page.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(routes: [
    GoRoute(path: AppRoutes.home, builder: (context, state) => const HomePage()),
    GoRoute(path: AppRoutes.search, builder: (context, state) => const SearchPage()),
  ]);


  static GoRouter get router => _router;

}