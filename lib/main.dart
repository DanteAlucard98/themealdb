import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recetas_adpp_2025/bloc/providers.dart';
import 'package:recetas_adpp_2025/config/router/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

// Definición de colores del tema
class AppColors {
  static const Color primary = Color(0xFFDAAD6C); // #daad6c - Beige dorado
  static const Color secondary = Color(0xFFA98654); // #a98654 - Marrón medio
  static const Color tertiary = Color(0xFF7E6545); // Variante más oscura
  static const Color background = Color(0xFFF5F1EA); // Beige claro para fondos
  static const Color cardBackground = Color(0xFFFFFAF0); // Blanco hueso para tarjetas
  static const Color textPrimary = Color(0xFF3C3024); // Marrón oscuro para texto principal
}

void main() async {
  // Asegurarse de que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cargar el archivo .env
  await dotenv.load(fileName: ".env.template");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Clase para obtener el root de la aplicación
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      //Carga los providers
      builder: (context, child) => AppProviders(
        child: ResponsiveBreakpoints.builder(
          //Carga la aplicación
          child: MaterialApp.router(
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
            //Tema de la aplicación
            theme: ThemeData(
              primaryColor: AppColors.primary,
              scaffoldBackgroundColor: AppColors.background,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                primary: AppColors.primary,
                secondary: AppColors.secondary,
                tertiary: AppColors.tertiary,
                background: AppColors.background,
                surface: AppColors.cardBackground,
              ),
              //Tema de la tarjeta
              cardTheme: CardTheme(
                color: AppColors.cardBackground,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              //Tema de la barra de navegación
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              //Tema de los textos
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: AppColors.textPrimary),
                bodyMedium: TextStyle(color: AppColors.textPrimary),
                titleLarge: TextStyle(color: AppColors.textPrimary),
              ),
              //Tema de los inputs
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: AppColors.cardBackground,
              ),
              //Tema de las transiciones
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                },
              ),
            ),
          ),
          //Breakpoints de la aplicación (Se acomode dependiendo del dispositivo)
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
