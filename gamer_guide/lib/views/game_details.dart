import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_details_model.dart';
import '../services/api_services.dart';
import '../services/data_provider.dart';

/* final userFutureProvider = FutureProvider<List<GameDetailsModel>>(
    (ref) => GameServices().getGameDetails(gameId)); */

class GameDetails extends ConsumerWidget {
  final String gameId;
  GameDetails({super.key, required this.gameId});

  final userFutureProvider = FutureProvider<List<GameDetailsModel>>(
      (ref) => GameServices().getGameDetails(727));

  Widget build(BuildContext context, WidgetRef ref) {
    /*  final userFutureProvider =
        FutureProvider<List<GameDetailsModel>>((ref) async {
      return ref.watch(gameProvider(int.parse(gameId))).getGameDetails(727);
    }); */
    final gameData = ref.watch(userFutureProvider);
    return Scaffold(
      body: gameData.when(
          data: (gameData) {
            List<GameDetailsModel> game = gameData.map((e) => e).toList();
            return Center(
                child: MyText(
              text: game[0].name!,
            ));
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
