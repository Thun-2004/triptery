import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:google_sign_in/google_sign_in.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptery/presentation/pages/home_page.dart';
import 'package:triptery/data/datasources/supabase_client.dart'; 
import 'package:twitter_login/twitter_login.dart';
import 'dart:io'; 

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String mode = "login";
  String? _userId; 
  // final supabase = Supabase.instance.client;

  @override
  void initState() {
    _setupAuthListener();
    super.initState();

    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
        print("User ID: $_userId");
      }); 
    });
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event; 
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(), 
          )
        );
      }
    }); 
  }

  Future<AuthResponse> _googleSignIn() async {
    const webClientId = '984517736433-88ufon0a877n7nq8ia8kdf1au450hr34.apps.googleusercontent.com';
    const iosClientId = '984517736433-7mfdksmgse5omhgmi3gb5vk9bpt6oa1i.apps.googleusercontent.com';

    // const androidClientId = '984517736433-g6mlh65c40idp50e3photdu9dt9h16na.apps.googleusercontent.com'; 
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

  Future<void> _facebookSignIn() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: 'io.supabase.travelapp://login-callback/', // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode: LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  Future<void> _twitterSignin() async {
    // final String apiKey = 'S9GzajUq5r5V4VIvT0V0M1HrP';
    // final String apiSecretKey = 'U6NhHZxqRahi2StQYLz6mVhMZEow1HsaZ6igkNgJa47dfQ4fhI';

    // final twitterLogin = TwitterLogin(
    //   /// Consumer API keys
    //   apiKey: apiKey,

    //   /// Consumer API Secret keys
    //   apiSecretKey: apiSecretKey,

    //   /// Registered Callback URLs in TwitterApp
    //   /// Android is a deeplink
    //   /// iOS is a URLScheme
    //   redirectURI: 'https://rscgnezldffdhjyhincy.supabase.co/auth/v1/callback',
    // );

    // /// Forces the user to enter their credentials
    // /// to ensure the correct users account is authorized.
    // /// If you want to implement Twitter account switching, set [force_login] to true
    // /// login(forceLogin: true);
    // final authResult = await twitterLogin.loginV2();
    // switch (authResult.status) {
    //   case TwitterLoginStatus.loggedIn:
    //     // success
    //     print('====== Login success ======');
    //     break;
    //   case TwitterLoginStatus.cancelledByUser:
    //     // cancel
    //     print('====== Login cancel ======');
    //     break;
    //   case TwitterLoginStatus.error:
    //   case null:
    //     // error
    //     print('====== Login error ======');
    //     break;
    // }

    await supabase.auth.signInWithOAuth(
      OAuthProvider.twitter,
      redirectTo: kIsWeb ? null : 'io.supabase.travelapp://login-callback/', // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode:
          kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
    );
    // await supabase.auth.signInWithOAuth(
    //   OAuthProvider.twitter,
    //   redirectTo: 'com.example.triptery://login-callback',
    //   authScreenLaunchMode: LaunchMode.externalApplication,
    // );

  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
 
      // height: mode == "signup" ? 1000 : 500,
      decoration: BoxDecoration(
        color: Color(0xFF3A373C).withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap:
                            () => setState(() {
                              mode = "login";
                            }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                mode == "login"
                                    ? const Color(0xFFF55548)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Log In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  mode == "login" ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap:
                            () => setState(() {
                              mode = "signup";
                            }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                mode == "signup"
                                    ? const Color(0xFFF55548)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  mode == "signup"
                                      ? Colors.white
                                      : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            mode == "signup"
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20), 
                    Text("Full Name", style: TextStyle(color: Colors.white)),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ), // Add border radius here
                          // Optional: white input background
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Full Name',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ],
                )
                : SizedBox.shrink(),

            const SizedBox(height: 20),
            Text("Email", style: TextStyle(color: Colors.white)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ), // Add border radius here
                  // Optional: white input background
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text("Password", style: TextStyle(color: Colors.white)),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      // value: null,
                      onChanged: (val) {
                        // Handle checkbox state change
                      },
                      // onChanged: (val) => setState(() => rememberMe = val!),
                      activeColor: Colors.white,
                    ),
                    const Text(
                      "Remember me",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // forgot password
                  },
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                //tickbox
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle login action
                },

                //q: sizebox vs container
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF55548),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  mode == "signup" ? "Sign Up" : "Login",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: Divider(color: Colors.white)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Or login with",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(child: Divider(color: Colors.white)),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlutterSocialButton(
                  onTap: () => _googleSignIn(), 
                  buttonType: ButtonType.google,
                  mini: true,
                  title: 'Google!',
                ),
                FlutterSocialButton(
                  onTap: () => _facebookSignIn(),
                  buttonType: ButtonType.facebook,
                  mini: true,
                  title: 'Facebook!',
                ),

                // if (Platform.isIOS)
                FlutterSocialButton(
                  onTap: () {},
                  buttonType: ButtonType.apple,
                  mini: true,
                  title: 'Apple!',
                ),

                FlutterSocialButton(
                  onTap: () => _twitterSignin(),
                  buttonType: ButtonType.twitter,
                  mini: true,
                  title: 'Twitter!',
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle Google login action
                //   },
                //   child: const Text("Google"),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 14,
                //       horizontal: 14,
                //     ),
                //   ),
                // ),

                // ElevatedButton(
                //   onPressed: () {
                //     // Handle Google login action
                //   },
                //   child: const Text("Facebook"),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 14,
                //       horizontal: 14,
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle Google login action
                //   },
                //   child: const Text("Apple"),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 14,
                //       horizontal: 14,
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle Google login action
                //   },
                //   child: const Text("Instagram"),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 14,
                //       horizontal: 14,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
