import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final supabase = Supabase.instance.client;

  // CADASTRO
  Future signUp(String email, String password) async {

    await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // LOGIN
  Future signIn(String email, String password) async {

    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // LOGOUT
  Future signOut() async {

    await supabase.auth.signOut();
  }
}