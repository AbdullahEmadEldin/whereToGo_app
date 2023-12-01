import 'package:get_it/get_it.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';

final locator = GetIt.instance;
void setUp() {
  locator.registerLazySingleton<PhoneAuthCubit>(() => PhoneAuthCubit());
}
