// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:maps_app/theme/app_theme.dart';
import 'package:maps_app/util/locator.dart';

class OptionTile extends StatelessWidget {
  final IconData leadingIcon;
  final Color? iconColor;
  final Widget title;
  final Widget? trailing;
  final Function()? onTap;
  const OptionTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.iconColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: iconColor ??
              (locator.get<ThemeData>() == AppThemes.lightAppTheme
                  ? kLightColorScheme.primary
                  : Colors.red),
        ),
        title: title,
        trailing: trailing,
      ),
    );
  }
}
