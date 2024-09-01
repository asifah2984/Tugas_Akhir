import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingProfileScreen extends StatefulWidget {
  const SettingProfileScreen({super.key});

  static const name = 'update-profile';
  static const path = 'update-profile';

  @override
  State<SettingProfileScreen> createState() => _SettingProfileScreenState();
}

class _SettingProfileScreenState extends State<SettingProfileScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _usernameController.text = context.read<UserNotifier>().user!.name;
    _emailController.text = context.read<UserNotifier>().user!.email;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFIL AKUN'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextInputField(
            controller: _usernameController,
            readOnly: true,
            labelText: 'Nama',
          ),
          const SizedBox(height: 12),
          TextInputField(
            controller: _emailController,
            readOnly: true,
            labelText: 'Email',
          ),
        ],
      ),
    );
  }
}
