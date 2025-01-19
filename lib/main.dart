import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text/Image_Picker/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://tfrqxhncpjpgspwqkqia.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRmcnF4aG5jcGpwZ3Nwd3FrcWlhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzcyNzI3MTIsImV4cCI6MjA1Mjg0ODcxMn0.MJZxiJkw-Kp62yM8jbBaoGyd9ZGOY3fRBedCjTGHNdw',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        //primaryColor: Colors.orange,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
