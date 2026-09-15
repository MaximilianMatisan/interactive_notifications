import 'package:flutter/material.dart';

import '../../pages/home_page.dart';
import '../../style/text_field.dart';
import 'login_header.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey;

  const LoginForm({super.key, required this._formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        children: [
          Spacer(),

          LoginHeader(),

          const SizedBox(height: 70),

          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
              border: defaultTextInputBorder(),
            ),
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: defaultTextInputBorder(),
            ),
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),

          const SizedBox(height: 30),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: const Size(120, 55),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //TODO API
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => MyHomePage()),
                  );
                }
              },
              child: Text(
                'LOGIN',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Spacer(),
          Center(
            child: TextButton(onPressed: () {/*TODO*/}, child: const Text('Contact')),
          ),
        ],
      ),
    );
  }
}
