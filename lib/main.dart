import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partypilot/views/checkSessions.dart';
import 'package:partypilot/database.dart';
import 'package:partypilot/saved_data.dart';
import 'package:partypilot/views/homepage.dart';

import 'package:partypilot/views/login.dart';
import 'package:partypilot/views/signup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavedData.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
         useMaterial3: true,
      ).copyWith(textTheme: GoogleFonts.interTextTheme()),
      home: const CheckSessions(),
    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
