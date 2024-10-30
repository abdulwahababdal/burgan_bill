import 'package:burgan_bill/pages/homepage.dart';
import 'package:burgan_bill/pages/signin.dart';
import 'package:burgan_bill/pages/signup.dart';
import 'package:burgan_bill/pages/splash_screen.dart';
import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:burgan_bill/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is initialized before calling async code

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user", "fakeuser");
  prefs.setString(
      "token", "82|7OMNhk6woETGj7Se2R7Qhw8D2ayrTwRKZxQkaKr661e6a93f");

  var authProvider = AuthProvider();
  await authProvider.getToken(); // Initialize authentication

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
      ],
      child: MyApp(),
    ),
  );

  // Uncomment the following to add more providers as needed
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider<PostProviders>(create: (_) => PostProviders()),
  //       ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
  //       ChangeNotifierProvider<ExerciseProvider>(create: (_) => ExerciseProvider()),
  //       ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
  //       ChangeNotifierProvider<MeditationProvider>(create: (_) => MeditationProvider()),
  //       ChangeNotifierProvider<MusicProvider>(create: (_) => MusicProvider()),
  //     ],
  //     child: MyApp(),
  //   ),
  // );
}

// class ThemeNotifier with ChangeNotifier {
//   bool _isDarkMode = false;

//   bool get isDarkMode => _isDarkMode;

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',

        builder: (context, state) => TelecomAndSubscriptionSelectionPage(),

        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => SigninPage(),

      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupPage(),
      ),
      // Uncomment to add more routes
      // GoRoute(
      //   path: '/yoga',
      //   builder: (context, state) => YogaPage(),
      // ),
      // GoRoute(
      //   path: '/music',
      //   builder: (context, state) => MusicListPage(),
      // ),
      // GoRoute(
      //   path: '/tips',
      //   builder: (context, state) => TipsPage(),
      // ),
      // GoRoute(
      //   path: '/meditation',
      //   builder: (context, state) => MeditationListPage(),
      // ),
      // GoRoute(
      //   path: '/settings',
      //   builder: (context, state) => SettingsPage(),
      // ),
      // GoRoute(
      //   path: '/addtip',
      //   builder: (context, state) => AddTipForm(),
      // ),
      // GoRoute(
      //   path: '/profile',
      //   builder: (context, state) => ProfilePage(),
      // ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      // Uncomment for custom theme handling
      // theme: ThemeNotifier().isDarkMode ? darkTheme() : lightTheme(),
    );
  }

  // Example theme methods
  // ThemeData lightTheme() {
  //   return ThemeData(
  //     brightness: Brightness.light,
  //     primaryColor: Colors.blue,
  //   );
  // }

  // ThemeData darkTheme() {
  //   return ThemeData(
  //     brightness: Brightness.dark,
  //     primaryColor: Colors.deepPurple,
  //   );
  // }
}
