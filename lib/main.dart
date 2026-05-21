import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bindings/auth_binding.dart';
import 'bindings/main_binding.dart';
import 'views/login_page.dart';
import 'views/main_page.dart';
import 'views/book_detail_page.dart';
import 'views/favorite_spell_page.dart';
import 'views/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('favorite_spells');

  // Cek Auto-Login
  final prefs = await SharedPreferences.getInstance();
  final String? savedUsername = prefs.getString('username');
  final String initialRoute =
      (savedUsername != null && savedUsername.isNotEmpty) ? '/main' : '/login';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pink Game Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.pinkAccent,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/main',
          page: () => const MainPage(),
          binding: MainBinding(),
        ),
        GetPage(name: '/detail', page: () => const BookDetailPage()),
        GetPage(name: '/favorite', page: () => const FavoriteSpellPage()),
        GetPage(name: '/cart', page: () => const FavoriteSpellPage()), // alias
        GetPage(name: '/profile', page: () => const ProfilePage()),
      ],
    );
  }
}
