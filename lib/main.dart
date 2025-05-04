import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'services/auth_service.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // Agregamos aquí si tenemos otros provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Librería Flutter',
      theme: AppTheme.lightTheme,
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
