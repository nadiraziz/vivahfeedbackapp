import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivah/screens/core/constant.dart';
import 'package:vivah/screens/home/home_screen.dart';

import '../../services/authenticate/auth.dart';
import 'widgets/email_controller.dart';
import 'widgets/password_controller.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final snackBar = const SnackBar(
    backgroundColor: Colors.red,
    content: Text('No account exist on this email and password'),
  );
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child:
                    Image.asset('assets/images/login.png', fit: BoxFit.contain),
              ),
              kHeight10,
              const Text(
                'Admin Login',
                style: kH2TextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    EmailController(emailController: _emailController),
                    kHeight10,
                    PasswordController(passwordController: _passwordController),
                    kHeight10,
                    ElevatedButton(
                      style: TextButton.styleFrom(),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authService.signInWithEmailPassword(
                              _emailController.text, _passwordController.text);
                          if (authService.user != null) {
                            Navigator.pushNamed(context, HomeScreen.id);
                          } else {
                            Navigator.canPop(context);
                          }
                        }
                      },
                      child: const Text('LOGIN'),
                    ),
                    kHeight10,
                  ],
                ),
              )
            ],
          )),
    );
  }
}
