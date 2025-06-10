

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptery/data/datasources/supabase_client.dart';

class SupabaseAuth {

  static Future<void> signUpNewUser(String email, String password) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password
    );
  }

  //password less sign in 
  static Future<void> signInWithEmail(String email) async {
    await supabase.auth.signInWithOtp(email: email);
  }
}