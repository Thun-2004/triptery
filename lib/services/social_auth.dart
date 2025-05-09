

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:triptery/data/datasources/supabase_client.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';


class SocialAuthService {

  static Future<AuthResponse> googleSignIn() async {
    var webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'] ;
    var iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID'] ;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  static Future<void> googleSignIn2() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: dotenv.env['REDIRECT_URI'], // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode: LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  static Future<void> facebookSignIn() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: dotenv.env['REDIRECT_URI'], // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode: LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  static Future<void> twitterSignin() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.twitter,
      redirectTo: kIsWeb ? null : dotenv.env['REDIRECT_URI'], // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode:
          kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}