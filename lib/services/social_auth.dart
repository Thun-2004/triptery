

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:triptery/data/datasources/supabase_client.dart'; 


class SocialAuthService {

  static var redirectUri = 'io.supabase.travelapp://login-callback/';

  static Future<AuthResponse> googleSignIn() async {
    var webClientId = '984517736433-88ufon0a877n7nq8ia8kdf1au450hr34.apps.googleusercontent.com' ;
    var iosClientId = '984517736433-7mfdksmgse5omhgmi3gb5vk9bpt6oa1i.apps.googleusercontent.com' ;

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
      redirectTo: redirectUri, // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode: LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  static Future<void> facebookSignIn() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: redirectUri, // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode: LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  static Future<void> twitterSignin() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.twitter,
      redirectTo: kIsWeb ? null : redirectUri, // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode:
          kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}