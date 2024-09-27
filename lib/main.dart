import 'dart:ui';

import 'package:ai_document_app/router.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/view/auth/forgot_password_view.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:ai_document_app/view/auth/signup_view.dart';
import 'package:ai_document_app/view/auth/verification_otp_view.dart';
import 'package:ai_document_app/view/home/home_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'view/auth/add_new_password_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    usePathUrlStrategy();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/',
      onGenerateInitialRoutes: (initialRoute) {
        final Uri uri = Uri.parse(initialRoute);
        return [
          buildPage(path: uri.path, queryParams: uri.queryParameters),
        ];
      },
      onGenerateRoute: (RouteSettings settings) {
        final Uri uri = Uri.parse(settings.name ?? '/');
        return buildPage(path: uri.path, queryParams: uri.queryParameters);
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryBlack,
        hintColor: primaryBlack,
        iconTheme: const IconThemeData(color: primaryBlack, size: 24),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16, // Larger font size for TextButton
              fontWeight: FontWeight.w600, // Semi-bold text
            ),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // Set dialog background color
          titleTextStyle: AppTextStyle.normalBold18, // Set title color
          contentTextStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ), // Set content color
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            primaryBlack.value,
            const {
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
        iconTheme: const IconThemeData(color: primaryBlack, size: 24),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16, // Larger font size for TextButton
              fontWeight: FontWeight.w600, // Semi-bold text
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            primaryBlack.value,
            const {
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
          contentTextStyle: const TextStyle(
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
    );
  }
}

// onGenerateRoute route switcher.
// Navigate using the page name, `Navigator.pushNamed(context, ListPage.name)`.
Route<dynamic> buildPage(
    {required String path, Map<String, String> queryParams = const {}}) {
  return Routes.noAnimation(
      settings: RouteSettings(
          name: (path.startsWith('/') == false) ? '/$path' : path),
      builder: (context) {
        String pathName =
            path != '/' && path.startsWith('/') ? path.substring(1) : path;
        return switch (pathName) {
          '/' || LoginView.name => LoginView(),
          HomeView.name => HomeView(),
          ForgotPasswordView.name => ForgotPasswordView(),
          SignupView.name => SignupView(),
          VerificationOtpView.name => VerificationOtpView(),
          AddNewPasswordView.name => AddNewPasswordView(),
          _ => const SizedBox.shrink(),
        };
      });
}

// Navigate to a named route
void navigateTo(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

// Navigate to a named route and remove the current route from the stack
void navigateAndRemove(BuildContext context, String routeName) {
  Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
}

// Go back to the previous route
void navigateBack(BuildContext context) {
  Navigator.pop(context);
}

// Navigate to a route and pass arguments
void navigateWithArguments(
    BuildContext context, String routeName, Object arguments) {
  Navigator.pushNamed(context, routeName, arguments: arguments);
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
