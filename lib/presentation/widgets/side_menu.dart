import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:maps_app/presentation/widgets/option_tile.dart';
import 'package:maps_app/theme/app_theme.dart';
import 'package:maps_app/util/locator.dart';
import 'package:maps_app/util/navigation/routes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            _buildInfoHeader(context, size),
            const OptionTile(
                leadingIcon: Icons.history, title: Text('Search history')),
            _buildDivider(),
            const OptionTile(
                leadingIcon: Icons.settings, title: Text('Settings')),
            _buildDivider(),
            const OptionTile(leadingIcon: Icons.help, title: Text('Help')),
            _buildDivider(),
            BlocProvider<PhoneAuthCubit>(
              create: (context) => locator.get<PhoneAuthCubit>(),
              child: OptionTile(
                leadingIcon: Icons.logout_rounded,
                iconColor: Colors.red,
                title: Text('Log out'),
                onTap: () {
                  locator.get<PhoneAuthCubit>().logOut();
                  context.goNamed(AppRoutes.phoneEnterScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoHeader(BuildContext context, Size size) {
    return Container(
      color: locator.get<ThemeData>() == AppThemes.lightAppTheme
          ? kLightColorScheme.primary
          : Colors.red,
      padding: EdgeInsets.zero,
      height: size.height * 0.23,
      width: double.infinity,
      child: Card(
        shape: const ContinuousRectangleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CircleAvatar(
                radius: size.width * 0.1,
                backgroundImage:
                    const AssetImage('assets/images/Anonymous-Profile-pic.jpg'),
              ),
            ),
            Text(
              //TODO: store user name and profile image locally related to user.uid of firebase object
              'Abdullah Emad',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              locator.get<PhoneAuthCubit>().getUserInfo().phoneNumber!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 1,
      indent: 4,
      endIndent: 4,
    );
  }
}
