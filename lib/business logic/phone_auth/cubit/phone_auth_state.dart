part of 'phone_auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

final class Loading extends PhoneAuthState {}

final class PhoneNumberSubmitted extends PhoneAuthState {}

final class OtpVerified extends PhoneAuthState {}

final class Error extends PhoneAuthState {
  final String errorMsg;

  Error({required this.errorMsg});
}
