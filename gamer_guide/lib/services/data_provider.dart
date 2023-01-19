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
