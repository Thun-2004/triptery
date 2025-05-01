import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_social_button/flutter_social_button.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: deprecated_member_use
      // color: Colors.transparent,
      
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF3A373C).withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              isSelected[0] = true;
                              isSelected[1] = false;
                            }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected[0]
                                    ? const Color(0xFFF55548)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Log In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  isSelected[0] ? Colors.white : Colors.black,
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
                              isSelected[0] = false;
                              isSelected[1] = true;
                            }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected[1]
                                    ? const Color(0xFFF55548)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  isSelected[1] ? Colors.white : Colors.black,
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

            Spacer(),
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

            Spacer(),
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
            Spacer(),
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
                child: const Text(
                  "Login", 
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Colors.white
                  ),
                )
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                FlutterSocialButton(
                  onTap: () {},
                  buttonType: ButtonType.yahoo,
                  mini: true,
                  title: 'Yahoo!',
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Google login action
                  },
                  child: const Text("Facebook"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Google login action
                  },
                  child: const Text("Apple"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Google login action
                  },
                  child: const Text("Instagram"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
