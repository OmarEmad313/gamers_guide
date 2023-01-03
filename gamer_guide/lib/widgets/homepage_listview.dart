import 'package:flutter/material.dart';

class HomePageListview extends StatelessWidget {
  List<String> genres = ['shooter', 'adventure', 'puzzle', 'RPG'];
  HomePageListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 45,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: genres.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text(genres[index]),
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
