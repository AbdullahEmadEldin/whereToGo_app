import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_app/business%20logic/maps_cubit/cubit/maps_cubit.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/presentation/pages/home_page.dart';
import 'package:maps_app/presentation/pages/otp_page.dart';
import 'package:maps_app/presentation/pages/phone_enter_page.dart';
import 'package:maps_app/util/locator.dart';
import 'package:maps_app/util/navigation/routes.dart';

class AppRouter {
  static GoRouter router(String initialRoute) {
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
            name: AppRoutes.phoneEnterScreen,
            path: '/phoneEnterScreen',
            pageBuilder: (context, state) => MaterialPage(
                    child: BlocProvider(
                  create: (_) => locator.get<PhoneAuthCubit>(),
                  child: PhoneAuthPage(),
                )),
            routes: [
              GoRoute(
                name: AppRoutes.otpScreen,
                path: 'otpScreen/:phoneNumber',
                pageBuilder: (context, state) {
                  final String phoneNumber =
                      state.pathParameters['phoneNumber']!;
                  return MaterialPage(
                    child: BlocProvider.value(
                      value: locator.get<PhoneAuthCubit>(),
                      child: OtpPage(
                        phoneNumber: phoneNumber,
                      ),
                    ),
                  );
                },
              ),
            ]),
        GoRoute(
          name: AppRoutes.homePage,
          path: '/homeScreen',
          pageBuilder: (context, state) => MaterialPage(
              child: BlocProvider(
            create: (context) => locator.get<MapsCubit>(),
            child: const HomePage(),
          )),
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
  }
}
