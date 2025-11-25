import 'package:flutter/material.dart';
import 'package:uidisign05/core/style.dart';
import 'package:uidisign05/page/home/home_page.dart' show HomePage;
import 'package:uidisign05/page/splash_Page.dart';

// PAGE IMPORTS
import 'package:uidisign05/page/login_page.dart';
import 'package:uidisign05/page/sign_up.dart';

import 'package:uidisign05/page/add_food/add_food_page.dart'; // pastikan file ini ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeXce',
      debugShowCheckedModeBanner: false,
      theme: Stlyes.themeData(),

      // INITIAL PAGE
      home: const SplashPage(),

      // ROUTES
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/addFood': (context) => const AddFoodPage(), // DARI HOMEPAGE FAB BUTTON
      },

      // FUNGSI AGAR KEYBOARD TUTUP SAAT TAP DI LUAR TEXTFIELD
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: child!,
        );
      },
    );
  }
}
