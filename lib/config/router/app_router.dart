import 'package:go_router/go_router.dart';

import '../../screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: PrincipalScreen.name,
      builder: (context, state) => const PrincipalScreen(),
    ),
  ],
);
