import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/edit_profile.dart';
import 'package:flutter_application_2/views/favorite_games_page.dart';
import 'package:flutter_application_2/views/profile_page.dart';
import 'package:flutter_application_2/views/your_comments.dart';
import 'package:go_router/go_router.dart';
import 'views/comments.dart';
import 'views/game_details.dart';
import 'views/login.dart';
import 'views/navbar.dart';
import 'views/signup.dart';
import 'views/similarr_games.dart';
import 'views/your_lists.dart';

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
        primarySwatch: Colors.lightBlue,
        //useMaterial3: true,
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
        return Navbar(id: state.params["id"]!);
      },
    ),
    GoRoute(
      path: '/home/:id',
      builder: (BuildContext context, GoRouterState state) {
        return Navbar(id: state.params["id"]!);
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
    GoRoute(
      path: '/favoriteGames',
      builder: (context, state) {
        return const FavoriteGames();
      },
    ),
    GoRoute(
      path: '/yourComments',
      builder: (context, state) {
        return const YourComments();
      },
    ),
    GoRoute(
      path: '/yourLists',
      builder: (context, state) {
        return const YourLists();
      },
    ),
  ],
);
