// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  String verificationId = 'xxx';
  PhoneAuthCubit() : super(PhoneAuthInitial());
  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  Future<void> verifyOtp(String otpCode) async {
    print('vvvvverifyFUUUUUUUUUUUUUUUUUUUUk:: $verificationId');
    print('verifyFUUUUUUUUUUUUUUUUUUUUk:: $verificationId');

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    print('FUUUUUUUUUUUUUUUUUUUUk:: $verificationId');

    await _signIn(credential);
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getUserInfo() {
    return FirebaseAuth.instance.currentUser!;
  }

  ///-----------------------------------------
  /// Private methods helpers to make code readable
  /// ----------------------------------------

  Future<void> _signIn(PhoneAuthCredential credential) async {
    emit(Loading());
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(OtpVerified());
    } catch (e) {
      print('Error on sign in code: ${e.toString()}');
      emit(Error(errorMsg: e.toString()));
    }
  }

  ///in case of Automatic handling of the SMS code on Android devices and let you sign in
  _verificationCompleted(PhoneAuthCredential credential) async {
    await _signIn(credential);
  }

  _verificationFailed(FirebaseAuthException error) {
    print('error on verfivation: ${error.toString()}');
    emit(Error(errorMsg: error.toString()));
  }

  _codeSent(String verificationId, int? resendToken) {
    print('code sent ');
    print('Coode sent FUUUUUUUUUUUUUUUUUUUUk::111 ${verificationId}');

    this.verificationId = verificationId;
    print('code sent FUUUUUUUUUUUUUUUUUUUUk::2222 ${verificationId}');

    emit(PhoneNumberSubmitted());
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }
}
