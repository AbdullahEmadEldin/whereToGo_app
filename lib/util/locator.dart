import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maps_app/business%20logic/maps_cubit/cubit/maps_cubit.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/theme/app_theme.dart';

final locator = GetIt.instance;
ThemeData _appTheme = AppThemes.lightAppTheme;
void setUp() {
  locator.registerLazySingleton<PhoneAuthCubit>(() => PhoneAuthCubit());
  locator.registerLazySingleton<MapsCubit>(() => MapsCubit());
  locator.registerSingleton<ThemeData>(_appTheme);
}
