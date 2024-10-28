import 'package:burgan_bill/pages/homepage.dart';
import 'package:burgan_bill/pages/signin.dart';
import 'package:burgan_bill/pages/signup.dart';
import 'package:burgan_bill/pages/splash_screen.dart';
import 'package:burgan_bill/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is initialized before calling async code
  var authProvider = AuthProvider();

  // await authProvider.initializeAuth(); // Initialize authentication
  // authProvider.isAuth(); // Check if user is authenticated

  runApp(
    ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MyApp(),
    ),
  );

  // runApp(
  // MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider<PostProviders>(create: (_) => PostProviders()),
  //     ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
  //     ChangeNotifierProvider<ExerciseProvider>(create: (_) => ExerciseProvider()),
  //     ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
  //     ChangeNotifierProvider<MeditationProvider>(create: (_) => MeditationProvider()),
  //     ChangeNotifierProvider<MusicProvider>(create: (_) => MusicProvider()),
  //   ],
  //   child: MyApp(),
  // ),
  //  MyApp(),
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
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => SplashPage(),
      // ),
      GoRoute(
        path: '/',
        builder: (context, state) => SigninPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      // GoRoute(
      //   path: '/yoga',
      //   builder: (context, state) => YogaPage(),
      // ),
      // GoRoute(
      //   path: '/music',
      //   builder: (context, state) => MusicListPage(),
      // ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupPage(),
      ),
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
      // theme: ThemeNotifier().isDarkMode ? darkTheme() : lightTheme(),
    );
  }

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
