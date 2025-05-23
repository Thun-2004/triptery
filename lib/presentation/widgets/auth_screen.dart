import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptery/presentation/pages/home_page.dart';
import 'package:triptery/data/datasources/supabase_client.dart';
import 'package:triptery/services/social_auth.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 
import 'package:get/get.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String mode = "login";

  var status = {"status": "", "message": ""};
  var _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordCheckController = TextEditingController();
  String? displayText;

  //add full naem to db
  var fullNameController = TextEditingController();
  String? _userId;

  final scackBar = SnackBar(
    content: Text("Signin successful"),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.green,
  );

  Future _login<AuthResponse>() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      _formKey.currentState!.save();
      try {
        final res = await supabase.auth.signInWithOtp(
          email: email,
          emailRedirectTo: 'io.supabase.travelapp://login-callback/',
        );
        // Handle successful login
        print("Login successful");
        return AppLocalizations.of(context)!.loginLinkSend;
      } catch (e) {
        // Handle error
        displayText = "Login error: $e";
        print("Login error: $e");

        return "Login error: $e"; 
      }
    }
  }

  Future _signUp<String>() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      _formKey.currentState!.save();
      try {
        final res = await await supabase.auth.signUp(
          email: email,
          password: password,
        );
        print("Sign-up successful");

        setState(() {
          emailController.text = "";
          passwordController.text = "";
          fullNameController.text = "";
        });

        return AppLocalizations.of(context)!.signUpSuccessful;
      } catch (e) {
        print("Sign-up error: $e");
        return "Sign-up error: $e";

      }
    }
  }

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
        Get.off(const HomePage()); 
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => const HomePage()),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      
        child: Container(
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
            child: Form(
              key: _formKey,
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 2,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap:
                                  () => setState(() {
                                    mode = "login";                                    
                                    emailController.text = "";
                                    passwordController.text = "";
                                    fullNameController.text = "";
                                    _formKey.currentState!.reset();
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
                                  AppLocalizations.of(context)!.logIn,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        mode == "login"
                                            ? Colors.white
                                            : Colors.black,
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
                                    emailController.text = "";
                                    passwordController.text = "";
                                    fullNameController.text = "";
                                    _formKey.currentState!.reset();
                                   
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
                                  AppLocalizations.of(context)!.signUp,
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
                          Text(
                            AppLocalizations.of(context)!.fullName,
                            style: TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: fullNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // Add border radius here
                                // Optional: white input background
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: AppLocalizations.of(context)!.fullName,
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
                  Text(AppLocalizations.of(context)!.email, style: TextStyle(color: Colors.white)),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ), // Add border radius here
                        // Optional: white input background
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: AppLocalizations.of(context)!.email,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value)) {
                        return AppLocalizations.of(context)!.emailError;
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  Text(AppLocalizations.of(context)!.password, style: TextStyle(color: Colors.white)),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: AppLocalizations.of(context)!.password,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          !RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^(){}[\]\\/+<>=~_|])[A-Za-z\d@$!%*?&#^(){}[\]\\/+<>=~_|]{8,}$',
                          ).hasMatch(value)) {
                        return AppLocalizations.of(context)!.passwordError;
                      }
                      return null;
                    },
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
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
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
                      onPressed: () async {
                        if (mode == "signup") {
                          var res = _signUp();

                          // Handle successful sign-up
                         showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.info(
                              message: await res,
                            ),
                          );
                        } else {
                          var res = _login();
                          if (res != null) {
                            // Handle successful sign-up
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message: await res,
                              ),
                            );
                          }
                        }
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
                        mode == "signup" ? AppLocalizations.of(context)!.signUp : AppLocalizations.of(context)!.logIn,
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
                    children: [
                      const Expanded(child: Divider(color: Colors.white)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          AppLocalizations.of(context)!.orLoginWith,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.white)),
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

                      // FlutterSocialButton(
                      //   onTap: () => SocialAuthService.twitterSignin(),
                      //   buttonType: ButtonType.twitter,
                      //   mini: true,
                      //   title: 'Twitter!',
                      // ),

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
          ),
        ),
    );
  }
}
