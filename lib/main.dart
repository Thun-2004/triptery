import 'package:flutter/material.dart';
import 'package:triptery/presentation/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triptery/presentation/pages/login_page.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptery/services/social_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? (throw Exception('SUPABASE_URL is not set in the environment variables')),
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? (throw Exception('SUPABASE_ANON_KEY is not set in the environment variables')),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Design Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', // Set default font

        // Default button style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Default text style
        // textTheme: const TextTheme(
          // bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
          // bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
          // headlineSmall: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        // ),
        textTheme: GoogleFonts.montserratTextTheme(),
        // Default card style
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(8),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

