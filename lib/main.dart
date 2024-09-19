import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/view/home_view.dart';
import 'package:ai_document_app/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      theme: ThemeData(
        primaryColor: primaryBlack,
        hintColor: primaryBlack,
        iconTheme: IconThemeData(color: primaryBlack, size: 24),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 16, // Larger font size for TextButton
              fontWeight: FontWeight.w600, // Semi-bold text
            ),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // Set dialog background color
          titleTextStyle: AppTextStyle.normalBold18, // Set title color
          contentTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ), // Set content color
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            primaryBlack.value,
            {
              50: primaryBlack,
              100: primaryBlack,
              200: primaryBlack,
              300: primaryBlack,
              400: primaryBlack,
              500: primaryBlack,
              600: primaryBlack,
              700: primaryBlack,
              800: primaryBlack,
              900: primaryBlack,
            },
          ),
        ).copyWith(surface: primaryWhite),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          displayLarge: AppTextStyle.normalBold32,
          displayMedium: AppTextStyle.normalBold28,
          displaySmall: AppTextStyle.normalBold24,
          headlineMedium: AppTextStyle.normalBold20,
          headlineSmall: AppTextStyle.normalBold18,
          titleLarge: AppTextStyle.normalBold16,
          titleMedium: AppTextStyle.normalBold14,
          titleSmall: AppTextStyle.normalBold12,
          bodyLarge: AppTextStyle.normalRegular18,
          bodyMedium: AppTextStyle.normalRegular16,
          bodySmall: AppTextStyle.normalRegular14,
          labelLarge: AppTextStyle.normalBold10,
          labelMedium: AppTextStyle.normalRegular12,
          labelSmall: AppTextStyle.normalRegular8,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: primaryBlack,
        hintColor: primaryBlack,
        iconTheme: IconThemeData(color: primaryBlack, size: 24),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 16, // Larger font size for TextButton
              fontWeight: FontWeight.w600, // Semi-bold text
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            primaryBlack.value,
            {
              50: primaryBlack,
              100: primaryBlack,
              200: primaryBlack,
              300: primaryBlack,
              400: primaryBlack,
              500: primaryBlack,
              600: primaryBlack,
              700: primaryBlack,
              800: primaryBlack,
              900: primaryBlack,
            },
          ),
        ).copyWith(surface: primaryWhite),
        scaffoldBackgroundColor: Colors.white,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // Set dialog background color
          titleTextStyle: AppTextStyle.normalBold18, // Set title color
          contentTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ), // Set content color
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyle.normalBold32,
          displayMedium: AppTextStyle.normalBold28,
          displaySmall: AppTextStyle.normalBold24,
          headlineMedium: AppTextStyle.normalBold20,
          headlineSmall: AppTextStyle.normalBold18,
          titleLarge: AppTextStyle.normalBold16,
          titleMedium: AppTextStyle.normalBold14,
          titleSmall: AppTextStyle.normalBold12,
          bodyLarge: AppTextStyle.normalRegular18,
          bodyMedium: AppTextStyle.normalRegular16,
          bodySmall: AppTextStyle.normalRegular14,
          labelLarge: AppTextStyle.normalBold10,
          labelMedium: AppTextStyle.normalRegular12,
          labelSmall: AppTextStyle.normalRegular8,
        ),
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
  ],
);
