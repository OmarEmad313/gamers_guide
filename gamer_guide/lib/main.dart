import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/edit_profile.dart';
import 'package:flutter_application_2/views/favorite_games_page.dart';
import 'package:flutter_application_2/views/game_details_temp.dart';
import 'package:flutter_application_2/views/intro_screens/parent.dart';
import 'package:flutter_application_2/views/listGames.dart';
import 'package:flutter_application_2/views/profile_page.dart';
import 'package:flutter_application_2/views/user_preference.dart';
import 'package:flutter_application_2/views/your_comments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/bridge.dart';
import 'views/comments.dart';
import 'views/game_details.dart';
import 'views/genres_games.dart';
import 'views/navbar.dart';
import 'views/signup.dart';
import 'views/similarr_games.dart';
import 'views/your_lists.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  //print(fcmToken);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*  return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvidor = Provider.of<ThemeProvider>(context); */
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Flutter Demo',
      // themeMode: themeProvidor.themeMode,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColorDark: Colors.black,
          brightness: Brightness.dark
          //useMaterial3: true,
          ),
      /* darkTheme: MyThemes.darkTheme,
      theme: MyThemes.lightTheme, */
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Bridge();
        //return Navbar(id: state.params["id"]);
      },
    ),
    GoRoute(
      path: '/parentIntro',
      builder: (BuildContext context, GoRouterState state) {
        return const ParentsIntroScreen();
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
      path: '/gamedetails/:idGame',
      builder: (context, state) {
        return GameDetails(gameId: state.params["idGame"]!);
      },
    ),
    GoRoute(
      path: '/similarGames/:id',
      builder: (context, state) {
        return SimilarGamess(gameId: state.params["id"]!);
      },
    ),
    GoRoute(
      path: '/genreGames/:idGenre/:nameGenre',
      builder: (context, state) {
        return GenreGames(
            genreId: state.params["idGenre"]!,
            genreName: state.params["nameGenre"]!);
      },
    ),
    GoRoute(
      path: '/comments/:id/:name',
      builder: (context, state) {
        return Comments(
            gameId: state.params["id"]!, gameName: state.params["name"]!);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return const ProfilePage();
      },
    ),
    GoRoute(
      path: '/editProfile/:nameUser/:idUser',
      builder: (context, state) {
        return EditProfile(
          userName: state.params["nameUser"]!,
          userId: state.params["idUser"]!,
        );
      },
    ),
    GoRoute(
      path: '/favoriteGames/:idUser',
      builder: (context, state) {
        return FavoriteGames(userId: state.params["idUser"]!);
      },
    ),
    GoRoute(
      path: '/yourComments/:idUser',
      builder: (context, state) {
        return YourComments(userId: state.params["idUser"]!);
      },
    ),
    GoRoute(
      path: '/yourLists/:idUser',
      builder: (context, state) {
        return YourLists(userId: state.params["idUser"]!);
      },
    ),
    GoRoute(
      path: '/listGames/:nameList',
      builder: (context, state) {
        return ListGames(listName: state.params["nameList"]!);
      },
    ),
    GoRoute(
      path: '/userPreference',
      builder: (context, state) {
        return const UserPreference();
      },
    ),
  ],
);
