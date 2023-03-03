import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrtodo/bloc/auth/auth_cubit.dart';
import 'package:hrtodo/ui/screens/hr/task_list.dart';
import 'package:hrtodo/ui/screens/manager/assignment_list.dart';
import 'package:hrtodo/ui/widgets/base/button.dart';
import 'package:hrtodo/ui/widgets/base/input.dart';
import 'package:hrtodo/utils/app_colors.dart';
import 'package:hrtodo/utils/constant_helper.dart';
import 'package:hrtodo/utils/show_flutter_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthCubit _authCubit;

  final TextEditingController _usernameInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _authCubit,
      listener: (context, state) {
        if (state is LoginInit) {

        } else if (state is LoginFailed) {
          String errorMessage = state.message.contains("Invalid")
              ? AppLocalizations.of(context).invalidLogin
              : "an error occurred, please try again later";
          showFlutterToast(errorMessage);
        } else if (state is LoginSuccessful) {
          var nextPage = state.user.role == ConstantHelper.userRoleHR
              ? const TaskList()
              : state.user.role == ConstantHelper.userRoleManager
                  ? const AssignmentList()
                  : null;

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => nextPage!
          ));
        }
      },
      child: BlocBuilder(
        bloc: _authCubit,
        builder: (context, state) {
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
                      hint: AppLocalizations.of(context).inputUsername,
                    ),

                    const SizedBox(height: 16),

                    Input(
                      controller: _passwordInput,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Password',
                      hint: AppLocalizations.of(context).inputPassword,
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: Button(
                        disabled: _authCubit.isLoginLoading,
                        onPressed: () {
                          if (_usernameInput.text.isNotEmpty && _passwordInput.text.isNotEmpty) {
                            _authCubit.login(_usernameInput.text, _passwordInput.text);
                          }
                        },
                        label: _authCubit.isLoginLoading
                            ? AppLocalizations.of(context).loading
                            : AppLocalizations.of(context).login,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
