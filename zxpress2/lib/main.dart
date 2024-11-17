import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zxpress2/src/auth/Login.dart';
import 'package:zxpress2/src/auth/Register.dart';
import 'package:zxpress2/src/home/home.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        final email = state.uri.queryParameters['email'];
        return Homepage(email: email);  
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
      },
    ),
  ],
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'zxpress2',
      routerConfig: _router,
    );
  }
}