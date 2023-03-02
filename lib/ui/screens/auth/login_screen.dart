import 'package:flutter/material.dart';
import 'package:hrtodo/ui/screens/hr/task_list.dart';
import 'package:hrtodo/ui/widgets/base/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 24),

              const TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                  labelText: "Username",
                  prefix: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.person,
                      size: 16,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minHeight: 100),
                )
              ),

              const SizedBox(height: 16),

              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                )
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                child: Button(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TaskList()
                    ));
                  },
                  label: 'Login',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
