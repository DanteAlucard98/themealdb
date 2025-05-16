import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/screens.dart';

/// Custom transition for pages
CustomTransitionPage<void> buildPageWithDefaultTransition({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;
      
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      
      return SlideTransition(
        position: offsetAnimation, 
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: PrincipalScreen.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const PrincipalScreen(),
      ),
      routes: [
        GoRoute(
          path: 'detail/:mealId',
          name: 'detail-meals-screen',
          pageBuilder: (context, state) {
            final mealId = state.pathParameters['mealId']!;
            return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: DetailMealsScreen(mealId: mealId),
            );
          },
        ),
      ],
    ),
  ],
);
