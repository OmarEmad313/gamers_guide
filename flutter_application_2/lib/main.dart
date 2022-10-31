import 'package:flutter/material.dart';
import 'package:flutter_application_2/gameDetails.dart';
import 'package:flutter_application_2/login.dart';

import 'package:flutter_application_2/signup.dart';
import 'package:go_router/go_router.dart';

import 'navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreenWidget();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const myHomePage();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const Signup();
      },
    ),
    GoRoute(
      path: '/gamedetails',
      builder: (BuildContext context, GoRouterState state) {
        return const GameDetails();
      },
    ),
  ],
);
