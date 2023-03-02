import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrtodo/ui/screens/hr/task_list.dart';
import 'package:hrtodo/ui/widgets/base/button.dart';
import 'package:hrtodo/ui/widgets/base/input.dart';
import 'package:hrtodo/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).login,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500
                ),
              ),

              const SizedBox(height: 24),

              Input(
                controller: _usernameInput,
                label: 'Username',
                hint: 'Input username',
              ),

              const SizedBox(height: 16),

              Input(
                controller: _passwordInput,
                keyboardType: TextInputType.visiblePassword,
                label: 'Password',
                hint: 'Input password',
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: Button(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TaskList()
                    ));
                  },
                  label: AppLocalizations.of(context).login,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
