import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivah/screens/home/home_screen.dart';
import 'package:vivah/screens/welcome_screen/welcome_screen.dart';
import 'package:vivah/services/authenticate/auth.dart';
import 'package:vivah/services/authenticate/models/user.dart';

class WrapperScreen extends StatefulWidget {
  static String id = 'wrapper_screen';
  const WrapperScreen({Key? key}) : super(key: key);

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<UserModel?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserModel? user = snapshot.data;
          return user == null ? const WelcomeScreen() : const HomeScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }
      },
    );
  }
}
