import 'package:flutter/material.dart';
import 'package:vivah/screens/authenticate/login_screen.dart';

import '../core/constant.dart';
import '../rating/customer_info.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/vivah.png',
            fit: BoxFit.contain,
            width: double.infinity,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, CustomerInfo.id);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'FEEDBACK 📝',
                style: kH2TextStyle,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            child: const Text(
              'Admin',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
