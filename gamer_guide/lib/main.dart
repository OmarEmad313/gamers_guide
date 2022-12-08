import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/edit_profile.dart';
import 'package:flutter_application_2/views/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'views/comments.dart';
import 'views/game_details.dart';
import 'views/navbar.dart';
import 'views/signup.dart';
import 'views/similarr_games.dart';

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
        //return const SplashScreenWidget();
        return const Navbar();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const Navbar();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const Signup();
      },
    ),
    GoRoute(
      path: '/gamedetails/:id',
      builder: (context, state) {
        return GameDetails(gameId: state.params["id"]!);
      },
    ),
    GoRoute(
      path: '/similarGames/:id',
      builder: (context, state) {
        return SimilarGamess(gameId: state.params["id"]!);
      },
    ),
    GoRoute(
      path: '/comments',
      builder: (context, state) {
        return const Comments();
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return const ProfilePage();
      },
    ),
    GoRoute(
      path: '/editProfile',
      builder: (context, state) {
        return const EditProfile();
      },
    ),
  ],
);
