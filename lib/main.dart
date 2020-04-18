import 'package:br/screens/home_screen.dart';
import 'package:br/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITSSjob',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 103, 181, 254),
        primaryColorDark: Color.fromARGB(255, 30, 54, 76),

        textTheme: TextTheme(
          display2: GoogleFonts.nunito(
            fontSize: 45,
            color: Colors.white,
          ),
          button: GoogleFonts.nunito(
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
