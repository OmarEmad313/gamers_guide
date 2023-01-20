import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageListview extends StatelessWidget {
  HomePageListview({super.key});

  List<String> genresNames = [
    'Shooter',
    'Adventure',
    'Puzzle',
    'Racing',
    'Sport'
  ];
  List<int> genresIds = [5, 31, 9, 10, 14];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 45,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: genresNames.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: InkWell(
                onTap: () {
                  context.go(
                      '/genreGames/${genresIds[index]}/${genresNames[index]}');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text(genresNames[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
