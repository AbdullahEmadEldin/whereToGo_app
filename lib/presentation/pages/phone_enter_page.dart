import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:maps_app/util/navigation/routes.dart';

// ignore: must_be_immutable
class PhoneAuthPage extends StatelessWidget {
  PhoneAuthPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  late String phoneNumber;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _phoneFormKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 16),
                  child: Text(S.of(context).WhatIsYourPhoneNumber,
                      style: theme.textTheme.displayMedium),
                ),
                Text(S
                    .of(context)
                    .PleaseEnterYourPhoneNumberToVerifyYourAccount),
                SizedBox(height: size.height * 0.1),
                _buildPhoneFormFeild(context),
                SizedBox(height: size.height * 0.1),
                _buildNextButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneFormFeild(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: Text(
              // ignore: prefer_interpolation_to_compose_strings
              generateCountryFlag() + '  +20',
              style: const TextStyle(letterSpacing: 2.0),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: TextFormField(
              autofocus: true,
              style: const TextStyle(letterSpacing: 2.0),
              decoration: const InputDecoration(
                  border: InputBorder.none, counterText: ''),
              keyboardType: TextInputType.phone,
              maxLength: 11,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your number';
                } else if (value.length < 11) {
                  return 'Invalid number';
                }
                return null;
              },
              onSaved: (newValue) {
                phoneNumber = newValue!;
              },
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          context.goNamed(AppRoutes.otpScreen);
        },
        style: Theme.of(context)
            .elevatedButtonTheme
            .style!
            .copyWith(minimumSize: MaterialStatePropertyAll(Size(110, 50))),
        child: Text(S.of(context).Next),
      ),
    );
  }
}