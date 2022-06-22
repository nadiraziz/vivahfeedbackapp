import 'package:flutter/material.dart';
import 'package:vivah/screens/dashboard/widgets/customer_dashboard_screen.dart';
import 'package:vivah/screens/dashboard/widgets/rating_analytics.dart';

class DashBoardScreen extends StatefulWidget {
  static String id = 'dashboard_screen';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DASHBOARD'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(3.0),
        children: [
          ButtonLogoTitle(
            title: 'User',
            icon: Icons.verified_user,
            path: CustomerInfoDashBoard.id,
          ),
          ButtonLogoTitle(
            title: 'Analytics',
            icon: Icons.bar_chart,
            path: RatingAnalytics.id,
          ),
        ],
      ),
    );
  }
}

class ButtonLogoTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Object path;
  const ButtonLogoTitle({
    Key? key,
    required this.title,
    required this.icon,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, path.toString());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
              ),
              Text(title),
            ],
          )),
    );
  }
}
