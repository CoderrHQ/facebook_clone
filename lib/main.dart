import 'package:facebook_clone/config/themes/app_theme.dart';
import 'package:facebook_clone/core/screens/home_screen.dart';
import 'package:facebook_clone/core/screens/loader.dart';
import 'package:facebook_clone/features/auth/presentation/screens/login_screen.dart';
import 'package:facebook_clone/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme(),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (snapshot.hasData) {
            final user = snapshot.data;
            if (user!.emailVerified) {
              return const HomeScreen();
            } else {
              return const VerifyEmailScreen();
            }
          }

          return const LoginScreen();
        },
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
