import 'package:burgan_bill/pages/homepage.dart';
import 'package:burgan_bill/pages/otp.dart';
import 'package:burgan_bill/pages/settings_page.dart';
import 'package:burgan_bill/pages/signin.dart';
import 'package:burgan_bill/pages/signup.dart';
import 'package:burgan_bill/pages/splash_screen.dart';
import 'package:burgan_bill/pages/sub.dart';
import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:burgan_bill/pages/subscription_success_page.dart';
import 'package:burgan_bill/pages/telecom_bill_page.dart';
import 'package:burgan_bill/pages/bill_amount_page.dart'; // Import the BillAmountPage
import 'package:burgan_bill/provider/auth_provider.dart';
import 'package:burgan_bill/provider/theme_provider.dart';
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
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        //  ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashPage()),
      GoRoute(
        path: '/signin',
        builder: (context, state) => SigninPage(),
        routes: [
          GoRoute(
            path: 'otp',
            name: 'otp',
            builder: (context, state) => OtpPage(email: state.extra as String),
          ),
          GoRoute(path: 'signup', builder: (context, state) => SignupPage()),
        ],
      ),
      GoRoute(path: '/dashboard', builder: (context, state) => Dashboard()),
      GoRoute(
          path: '/subscription-success',
          builder: (context, state) => SubscriptionSuccessPage()),
      GoRoute(
        path: '/subscription',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SubscriptionPage(
            serviceName: extra?['serviceName'] ?? 'Service',
            logoPath: extra?['logoPath'] ?? '',
            options: extra?['options'] ?? [],
          );
        },
      ),
      GoRoute(
        path: '/telecom-bill',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return TelecomBillPage(
            serviceName: args['serviceName'] as String,
            logoPath: args['logoPath'] as String,
            amountDue: args['amountDue'] as double,
          );
        },
      ),
      GoRoute(
        path: '/bill-amount',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return BillAmountPage(
            serviceName: args['serviceName'] as String,
            logoPath: args['logoPath'] as String,
            amountDue: args['amountDue'] as double,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
