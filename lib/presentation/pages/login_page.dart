
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triptery/presentation/widgets/auth_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); 

  @override
  State<LoginPage> createState() => _LoginPageState(); 
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _targetKey = GlobalKey();

  void _openBottomModal(){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AuthScreen()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, 
        children: [
          Image.asset(
            'assets/images/login_wallpaper.png', 
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //logo not show
                CustomSvgLogo(),
                const Spacer(),

                // Form Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title & Subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Login up to access your plan from any device",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Email Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF55548),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "EMAIL",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Facebook Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF324987),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "FACEBOOK",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Footer Text
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,

                            color: Colors.white,
                          ), 
                          children: [
                            TextSpan(
                              text: " Sign in",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle sign in action
                                  _openBottomModal(); 
                                },
                            ),
                          ]
                        ), 
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}

class CustomSvgLogo extends StatelessWidget {
  const CustomSvgLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      width: 224,
      height: 48,
      colorMapper: const BrandColorMapper(),
    );
  }
}

class BrandColorMapper extends ColorMapper {
  const BrandColorMapper();

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    // Example: Replace red with green
    if (color == const Color(0xFFFF0000)) {
      return Colors.green;
    }
    // Add more mappings as needed
    return color;
  }
}



