import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.indigo.shade100,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold);
        }
        return const TextStyle(color: Colors.indigo);
      }),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: Colors.indigo);
        }
        return const IconThemeData(color: Colors.indigo);
      }),
    ),
  );
}
