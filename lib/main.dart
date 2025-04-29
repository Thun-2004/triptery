import 'package:flutter/material.dart'; 


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'triptery', 
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        scaffoldBackgroundColor: Colors.white,
        fontFamily: '', 

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ), 
            textStyle: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold
            )
          )
        ), 

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontSize: 16), 
          bodyMedium: TextStyle(color: Colors.black54, fontSize: 14), 
          headlineSmall: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), 
        )

      ), 

      home: (supabase auth ? ) ? const LoginPage() : HomePage() , 

    ); 
  }
}
