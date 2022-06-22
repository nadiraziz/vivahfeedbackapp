import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivah/screens/core/constant.dart';
import 'package:vivah/screens/dashboard/dashboard_screen.dart';
import 'package:vivah/screens/welcome_screen/welcome_screen.dart';

import '../../services/authenticate/auth.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/vivah.png',
              height: 300,
              fit: BoxFit.cover,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DashBoardScreen.id);
              },
              child: const Text(
                'DASHBOARD',
                style: kH2TextStyle,
              ),
            ),
            MaterialButton(
              onPressed: () async {
                await authService.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, WelcomeScreen.id, (route) => false);
              },
              child: const Text('LOG OUT'),
            ),
          ],
        ),
      ),
    );
  }
}
