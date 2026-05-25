import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ikfxgciguckevcelligj.supabase.co',
    anonKey: 'sb_publishable_pwezEQmIJGC6bJcWacgO4g_wlrHlTMj',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      initialRoute: '/',

      routes: {

        '/': (context) {

          final user =
              Supabase.instance.client.auth.currentUser;

          // USUÁRIO LOGADO
          if (user != null) {
            return const HomeScreen();
          }

          // USUÁRIO NÃO LOGADO
          return const LoginScreen();
        },

        '/login': (context) => const LoginScreen(),

        '/register': (context) => const RegisterScreen(),

        '/home': (context) {

          final user =
              Supabase.instance.client.auth.currentUser;

          // PROTEÇÃO DA HOME
          if (user == null) {
            return const LoginScreen();
          }

          return const HomeScreen();
        },
      },
    );
  }
}