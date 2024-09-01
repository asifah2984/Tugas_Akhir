import 'package:alquran_app/core/common/widgets/app_divider.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/src/settings/presentation/views/setting_email_screen.dart';
import 'package:alquran_app/src/settings/presentation/views/setting_password_screen.dart';
import 'package:alquran_app/src/settings/presentation/views/setting_profile_screen.dart';
import 'package:alquran_app/src/settings/presentation/widgets/setting_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const name = 'settings';
  static const path = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PENGATURAN'),
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colours.grey400,
                ),
              ),
              child: Icon(
                FlutterIslamicIcons.prayer,
                color: context.colorScheme.secondary,
                size: 75,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const AppDivider(thickness: 6, height: 6),
          SettingMenuTile(
            label: 'Profil Akun',
            onPressed: () => context.pushNamed(SettingProfileScreen.name),
          ),
          const AppDivider(thickness: 6, height: 6),
          SettingMenuTile(
            label: 'Ganti Email',
            onPressed: () => context.pushNamed(SettingEmailScreen.name),
          ),
          const AppDivider(thickness: 6, height: 6),
          SettingMenuTile(
            label: 'Ganti Password',
            onPressed: () => context.pushNamed(SettingPasswordScreen.name),
          ),
          const AppDivider(thickness: 6, height: 6),
        ],
      ),
    );
  }
}
