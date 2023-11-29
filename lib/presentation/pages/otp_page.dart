import 'package:flutter/material.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  //late final String phoneNumber;

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
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {},
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            minimumSize: const MaterialStatePropertyAll(Size(110, 50))),
        child: Text(S.of(context).Verify),
      ),
    );
  }
}
