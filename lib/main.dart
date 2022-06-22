import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vivah/screens/authenticate/login_screen.dart';
import 'package:vivah/screens/dashboard/dashboard_screen.dart';
import 'package:vivah/screens/dashboard/widgets/customer_dashboard_screen.dart';
import 'package:vivah/screens/dashboard/widgets/rating_analytics.dart';
import 'package:vivah/screens/home/home_screen.dart';
import 'package:vivah/screens/rating/compents/end_video_screen.dart';
import 'package:vivah/screens/rating/customer_info.dart';
import 'package:vivah/screens/rating/rating_screen.dart';
import 'package:vivah/screens/welcome_screen/welcome_screen.dart';
import 'package:vivah/screens/wrapper_screen.dart';

import 'services/authenticate/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vivah FeedBack',
        theme: ThemeData(
          primaryTextTheme: GoogleFonts.latoTextTheme(),
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.amber).copyWith(
            secondary: const Color.fromRGBO(171, 105, 50, 0),
          ),
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        initialRoute: WrapperScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          WrapperScreen.id: (context) => const WrapperScreen(),
          CustomerInfo.id: (context) => const CustomerInfo(),
          LoginScreen.id: (context) => const LoginScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          DashBoardScreen.id: (context) => const DashBoardScreen(),
          EndVideoApp.id: (context) => EndVideoApp(),
          CustomerInfoDashBoard.id: (context) => const CustomerInfoDashBoard(),
          RatingAnalytics.id: (context) => const RatingAnalytics(),
          RatingScreen.id: (context) => const RatingScreen(
                customerPhone: '',
                customerName: '',
                customerEmail: '',
              ),
        },
      ),
    );
  }
}
