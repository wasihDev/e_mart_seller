import 'package:e_mart_seller/const/firebase_const.dart';
import 'package:e_mart_seller/firebase_options.dart';
import 'package:e_mart_seller/views/auth_screen/login_screen.dart';
import 'package:e_mart_seller/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  var isLoggedIn = false;
  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //     unselectedItemColor: Colors.red,
          //     unselectedIconTheme: IconThemeData(color: Colors.red)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0.0)),
      home: isLoggedIn ? const Home() : loginScreen(),
    );
  }
}
