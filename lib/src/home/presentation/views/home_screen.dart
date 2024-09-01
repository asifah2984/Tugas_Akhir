import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/al_quran/presentation/views/al_quran_screen.dart';
import 'package:alquran_app/src/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:alquran_app/src/auth/presentation/views/login_screen.dart';
import 'package:alquran_app/src/home/presentation/widgets/home_menu_button.dart';
import 'package:alquran_app/src/home/presentation/widgets/logout_dialog.dart';
import 'package:alquran_app/src/profile/presentation/views/profile_screen.dart';
import 'package:alquran_app/src/settings/presentation/views/settings_screen.dart';
import 'package:alquran_app/src/tajwid/presentation/views/tajwid_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const path = '/';
  static const name = 'home';

  Future<void> _logout(BuildContext context) async {
    final bloc = context.read<AuthBloc>();

    final confirmLogout = await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return const LogoutDialog();
      },
    );

    if (confirmLogout == null || confirmLogout == false) return;

    bloc.add(const AuthEvent.logoutUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          leading: !context.read<UserNotifier>().user!.isAdmin
              ? IconButton(
                  onPressed: () => context.pushNamed(ProfileScreen.name),
                  icon: const Icon(Icons.person),
                )
              : null,
          title: const Text('BELAJAR AL QURAN'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            HomeMenuButton(
              label: 'Al Quran',
              icon: FlutterIslamicIcons.quran2,
              onPressed: () => context.pushNamed(AlQuranScreen.name),
            ),
            const SizedBox(height: 12),
            HomeMenuButton(
              label: 'Fitur Tajwid',
              icon: FlutterIslamicIcons.crescentMoon,
              onPressed: () => context.pushNamed(TajwidScreen.name),
            ),
            const SizedBox(height: 12),
            HomeMenuButton(
              label: 'Pengaturan',
              icon: FlutterIslamicIcons.tasbihHand,
              onPressed: () => context.pushNamed(SettingsScreen.name),
            ),
            const SizedBox(height: 12),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                state.whenOrNull(
                  loggingOutUser: () => context.loaderOverlay.show(),
                  userLoggedOut: () {
                    context.read<UserNotifier>().resetUser();
                    context.loaderOverlay.hide();
                    context.goNamed(LogInScreen.name);
                  },
                  userLogoutFailed: (message) {
                    context.loaderOverlay.hide();
                    CoreUtils.showSnackBar(
                      context: context,
                      message: message,
                      type: SnackBarType.error,
                    );
                  },
                );
              },
              child: HomeMenuButton(
                label: 'Keluar',
                icon: FlutterIslamicIcons.lantern,
                onPressed: () => _logout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
