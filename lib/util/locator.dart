import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/theme/app_theme.dart';

final locator = GetIt.instance;
ThemeData _appTheme = AppThemes.lightAppTheme;

void setUp() {
  locator.registerLazySingleton<PhoneAuthCubit>(() => PhoneAuthCubit());
  locator.registerSingleton<ThemeData>(_appTheme);
  locator.registerLazySingleton<Set<Marker>>(() => Set());
}
