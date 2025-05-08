import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptery/presentation/pages/home_page.dart';
import 'package:triptery/data/datasources/supabase_client.dart'; 
import 'package:triptery/services/social_auth.dart';
import 'dart:io'; 

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String mode = "login";
  String? _userId; 

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
                  onTap: () => SocialAuthService.googleSignIn(), 
                  buttonType: ButtonType.google,
                  mini: true,
                  title: 'Google!',
                ),
                FlutterSocialButton(
                  onTap: () => SocialAuthService.facebookSignIn(),
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
                  onTap: () => SocialAuthService.twitterSignin(),
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
