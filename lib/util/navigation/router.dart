import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_app/presentation/pages/home_page.dart';
import 'package:maps_app/presentation/pages/phone_auth_page.dart';
import 'package:maps_app/util/navigation/routes.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.homePage,
    routes: [
      GoRoute(
        path: AppRoutes.phoneAuthScreen,
        pageBuilder: (context, state) =>
            const MaterialPage(child: PhoneAuthPage()),
      ),
      GoRoute(
        path: AppRoutes.homePage,
        pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
      )
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            body: Center(
              child: Text('Error on navigation: ${state.error.toString()}'),
            ),
          ));
    },
  );

  static GoRouter get router => _router;
}
