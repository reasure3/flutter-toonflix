import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:toonflix/screens/home_screen.dart';

final Logger logger = Logger("Toonflix");

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    log(
      '${record.level.name} ${record.time}: ${record.message}',
      name: record.loggerName,
      level: record.level.value,
      zone: record.zone,
      sequenceNumber: record.sequenceNumber,
      error: record.error,
      stackTrace: record.stackTrace,
      time: record.time,
    );
  });

  // ApiService.getTodaysToons();
  // logger.info("successfully get today's toons data: $a");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toonflix',
      theme: createTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      scrollBehavior: const MaterialScrollBehavior(),
      home: HomeScreen(),
    );
  }

  ThemeData createTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      primaryTextTheme: GoogleFonts.nanumGothicTextTheme(),
      textTheme: GoogleFonts.nanumGothicTextTheme(
        TextTheme(
          bodySmall: GoogleFonts.nanumGothic(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: GoogleFonts.nanumGothic(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.nanumGothic(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: GoogleFonts.nanumGothic(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: GoogleFonts.nanumGothic(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        shadowColor: Colors.black,
        centerTitle: true,
        titleTextStyle: GoogleFonts.nanumGothic(
          color: Colors.green,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
    );
  }
}
