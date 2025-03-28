import 'package:base_project/src/core/ui/tokens/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF232F69)),
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.latoTextTheme(),
      fontFamily: GoogleFonts.lato().fontFamily,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        centerTitle: true,
        titleTextStyle: GoogleFonts.lato(
          color: AppColors.onPrimary,
          fontSize: 16,
        ),
      ),

      tabBarTheme: TabBarTheme(
        indicatorColor: AppColors.secondary,
        indicatorSize: TabBarIndicatorSize.tab,

        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
      ),

      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),

      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.secondary;
          }
          return Colors.white;
        }),

        side: const BorderSide(color: AppColors.textPrimary, width: 1.5),
        checkColor: WidgetStateProperty.all(Colors.white),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}
