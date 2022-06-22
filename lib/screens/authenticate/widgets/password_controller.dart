import 'package:flutter/material.dart';

class PasswordController extends StatelessWidget {
  const PasswordController({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.emailAddress,
      validator: (val) => val!.length < 6 ? 'Enter 6+ character' : null,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: "Enter Password", labelText: "Password"),
    );
  }
}
