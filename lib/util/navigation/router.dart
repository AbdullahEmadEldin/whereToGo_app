import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/presentation/pages/home_page.dart';
import 'package:maps_app/presentation/pages/otp_page.dart';
import 'package:maps_app/presentation/pages/phone_enter_page.dart';
import 'package:maps_app/util/navigation/routes.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          name: AppRoutes.phoneAuthScreen,
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
                  child: BlocProvider(
                create: (_) => PhoneAuthCubit(),
                child: PhoneAuthPage(),
              )),
          routes: [
            GoRoute(
              name: AppRoutes.otpScreen,
              path: 'otpScreen',
              pageBuilder: (context, state) => MaterialPage(
                  child: BlocProvider(
                create: (_) => PhoneAuthCubit(),
                child: OtpPage(),
              )),
            ),
          ]),
      GoRoute(
        name: AppRoutes.homePage,
        path: '/homeScreen',
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
