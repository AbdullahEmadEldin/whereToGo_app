import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:maps_app/util/helpers.dart';
import 'package:maps_app/util/navigation/routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatelessWidget {
  //late final String phoneNumber;
  late String otpCode;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 16),
                  child: Text(S.of(context).VerfiyYourPhoneNumber,
                      style: theme.textTheme.displayMedium),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: S.of(context).EnterDigits,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(height: 1.4)),
                      const TextSpan(
                          text: 'phoneNumber',
                          style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                _buildPinCodeFields(context),
                SizedBox(height: size.height * 0.1),
                _buildVerifyButton(context),
                _buildCodeBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      length: 6,
      keyboardType: TextInputType.number,
      obscureText: false,
      animationType: AnimationType.scale,
      cursorColor: Colors.blue,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: const Color.fromARGB(255, 188, 226, 245),
        inactiveFillColor: Colors.white,
        activeColor: Colors.blue,
        inactiveColor: Colors.red,
        selectedColor: Colors.blue,
        selectedFillColor: Colors.white,
        errorBorderColor: Colors.red,
        borderWidth: 1,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (code) {
        otpCode = code;
      },
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<PhoneAuthCubit>(context).verifyOtp(otpCode);
        },
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            minimumSize: const MaterialStatePropertyAll(Size(110, 50))),
        child: Text(S.of(context).Verify),
      ),
    );
  }

  Widget _buildCodeBlocListener() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: ((context, state) {
        if (state is Loading) {
          showProgressInidcator(context);
        } else if (state is OtpVerified) {
          Navigator.pop(context);
          context.goNamed(AppRoutes.homePage);
        } else if (state is Error) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }),
      child: const SizedBox(),
    );
  }
}
