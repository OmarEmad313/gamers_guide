import 'package:flutter/material.dart';
import '../models/game_details_model.dart';

class HorizantalListview extends StatelessWidget {
  final List<GameDetailsModel> game;
  final bool isTheme;
  const HorizantalListview(
      {super.key, required this.game, required this.isTheme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            isTheme ? game[0].themes?.length ?? 1 : game[0].genres?.length ?? 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text(isTheme
                    ? (game[0].themes?[index].name ?? 'No Themes')
                    : (game[0].genres?[index].name ?? 'No Genres')),
              ),
            ),
          );
        },
      ),
    );
  }
}
