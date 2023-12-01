import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:maps_app/util/locator.dart';
import 'package:maps_app/util/navigation/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home pageeeee'),
      ),
      body: Column(
        children: [
          BlocProvider<PhoneAuthCubit>(
            create: (context) => PhoneAuthCubit(),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  locator.get<PhoneAuthCubit>().logOut();
                  context.goNamed(AppRoutes.phoneEnterScreen);
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    minimumSize: const MaterialStatePropertyAll(Size(110, 50))),
                child: Text(S.of(context).LogOut),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
