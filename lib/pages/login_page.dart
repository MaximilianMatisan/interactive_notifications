import 'package:flutter/material.dart';
import 'package:interactive_notifications/widgets/login/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  final String title = 'Login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.all(35),
        child: LoginForm(formKey: _formKey)
      ),
    );
  }
}
