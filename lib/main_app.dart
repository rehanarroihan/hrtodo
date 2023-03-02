import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrtodo/bloc/auth/auth_cubit.dart';
import 'package:hrtodo/bloc/task/task_cubit.dart';
import 'package:hrtodo/ui/screens/auth/login_screen.dart';
import 'package:yaru/yaru.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<TaskCubit>(create: (context) => TaskCubit()),
      ],
      child: YaruTheme(
          data: const YaruThemeData(
            variant: YaruVariant.prussianGreen,
          ),
          builder: (context, yaru, child) {
            return MaterialApp(
              title: 'HR To-do List',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: yaru.theme,
              darkTheme: yaru.darkTheme,
              home: const LoginScreen(),
            );
          }
      ),
    );
  }
}
