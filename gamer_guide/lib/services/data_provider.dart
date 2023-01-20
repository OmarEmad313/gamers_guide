import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../models/game_details_model.dart';
import '../models/list_records_model.dart';
import '../models/popular_games.dart';
import 'api_services.dart';
import 'user_lists_services.dart';

final gameDetailsProvider =
    FutureProvider.family<List<GameDetailsModel>, String>((ref, id) async {
  return ref.watch(gameProvider).getGameDetails(int.parse(id));
});

final popularGamesProvider = FutureProvider<List<GamesCoverModel>>((ref) async {
  return ref.watch(gameProvider).populargames();
});

final newGamesProvider = FutureProvider<List<GamesCoverModel>>((ref) async {
  return ref.watch(gameProvider).newgames();
});

final genreGamesProvider = FutureProvider.family<List<GamesCoverModel>, String>(
    (ref, genreName) async {
  return ref.watch(gameProvider).getGenreGameCovers(genreName);
});

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  /*  final userListsProvider = StreamProvider<QuerySnapshot>((ref) async {
  return ref.watch(userListsServicesProvider).fetchListsRecords('1');
}); */

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );
}
