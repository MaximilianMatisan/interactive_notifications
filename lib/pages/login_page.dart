import 'package:flutter/material.dart';

import 'home_page.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(20),
        child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  //TODO API
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyHomePage()));
                }
              },
              child: const Text('Login')
            )
          ],
        ),
      )
      )
    );
  }
}
