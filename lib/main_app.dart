import 'package:flutter/material.dart';
import 'package:hrtodo/screens/auth/login_screen.dart';
import 'package:yaru/yaru.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      data: const YaruThemeData(
        variant: YaruVariant.prussianGreen,
      ),
      builder: (context, yaru, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          home: const LoginScreen(),
        );
      }
    );
  }
}
