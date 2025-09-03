import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromARGB(255, 70, 109, 216),
    brightness: Brightness.light,
  );

  return base.copyWith(
    scaffoldBackgroundColor: Colors.transparent, // фон даёт картинка
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,       // без белой «полосы»
      elevation: 0,
      scrolledUnderElevation: 0,                 // не затемнять при скролле
      surfaceTintColor: Colors.transparent,
      foregroundColor: const Color.fromARGB(255, 249, 249, 249),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // тёмные иконки в статус-баре
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFE3F2FD).withValues(alpha: 0.92),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      hintStyle: const TextStyle(color: Colors.black54),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 70, 109, 216).withValues(alpha: 0.92),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        minimumSize: const Size.fromHeight(48),
      ),
    ),
  );
}
