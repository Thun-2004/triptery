import 'package:flutter/material.dart';
import 'package:triptery/presentation/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triptery/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptery/services/social_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:triptery/l10n/support_locale.dart';
import 'package:provider/provider.dart';
import 'package:triptery/presentation/controllers/language_controller.dart';
import 'package:triptery/presentation/pages/trip/trip_page.dart'; 
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: 'https://rscgnezldffdhjyhincy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJzY2duZXpsZGZmZGhqeWhpbmN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU0NzE3MjQsImV4cCI6MjA2MTA0NzcyNH0.gLDBGjcjwiBvg-t-3OsHunjdSL97UhvySQb31QDV8ws',
  );

  Get.put(LanguageController());
  Get.put(TripController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();


    return 
        GetMaterialApp(
          //like MaterialApp but with GetX features
          title: 'Global Design Example',
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.support,
          locale:
              languageController.lang ??
              const Locale('en', ''), // Set default locale
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
          // home: const LoginPage(),
          home: const TripPage(),
        );  
      
  }
}



