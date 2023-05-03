import 'package:flutter_application_2/models/recommended_games_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_details_model.dart';
import '../models/popular_games.dart';
import 'api_services.dart';

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

final recommendedGamesProvider =
    FutureProvider<List<RecommendedGamesModel>>((ref) async {
  return ref.watch(gameProvider).getRecommendedGames();
});

final genreGamesProvider = FutureProvider.family<List<GamesCoverModel>, String>(
    (ref, genreName) async {
  return ref.watch(gameProvider).getGenreGameCovers(genreName);
});

final ratedGamesNum = FutureProvider<int>((ref) async {
  return ref.watch(gameProvider).getNumber();
});
