import 'package:burgan_bill/pages/otp.dart';
import 'package:burgan_bill/pages/signin.dart';
import 'package:burgan_bill/pages/signup.dart';
import 'package:burgan_bill/pages/splash_screen.dart';
import 'package:burgan_bill/pages/sub.dart';
import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:burgan_bill/provider/auth_provider.dart';
import 'package:burgan_bill/provider/theme_provider.dart'; // Import ThemeProvider
import 'package:burgan_bill/widgets/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user", "fakeuser");
  prefs.setString(
      "token", "82|7OMNhk6woETGj7Se2R7Qhw8D2ayrTwRKZxQkaKr661e6a93f");

  var authProvider = AuthProvider();
  await authProvider.getToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ), // Add ThemeProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => SigninPage(),
        routes: [
          GoRoute(
            path: 'otp',
            name: 'otp',
            builder: (context, state) => OtpPage(
              email: state.extra as String,
            ),
          ),
          GoRoute(
            path: 'signup',
            builder: (context, state) => SignupPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => Dashboard(),
      ),
      GoRoute(
        path: '/sub',
        builder: (context, state) => SubscriptionPage(
          serviceName: "Premium Service",
          logoPath: "assets/logo.png",
          options: [
            SubscriptionOption(
              title: "Basic Plan",
              price: "\$5/month",
              features: ["Feature 1", "Feature 2"],
            ),
            SubscriptionOption(
              title: "Premium Plan",
              price: "\$10/month",
              features: ["Feature 1", "Feature 2", "Feature 3"],
            ),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: TelecomAndSubscriptionSelectionPage(),
    );
  }
}
