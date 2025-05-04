import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/detail_product_screen.dart';
import '../screens/cart_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterUserScreen(),
  'home': (_) => const HomeScreen(),
  'detalle': (_) => const DetailProductScreen(),
  'cart': (_) => const CartScreen(),
};
