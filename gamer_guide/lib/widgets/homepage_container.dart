import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/popular_games.dart';
import 'my_text.dart';

class HomePageContainer extends StatelessWidget {
  final String name;
  final String name2;
  final List<GamesCoverModel> covers;

  const HomePageContainer({
    super.key,
    required this.covers,
    required this.name,
    required this.name2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.black.withOpacity(0.5),
        ),
        height: MediaQuery.of(context).size.height * 0.325,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: name,
                  size: 20,
                  weight: FontWeight.bold,
                  underlined: true,
                ),
                MyText(
                  text: name2,
                  size: 17,
                  weight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.275,
              child: ListView.builder(
                itemCount: covers.length, //games!.length
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        context.go('/gamedetails/${covers[index].id}');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https:${covers[index].cover?.url!.replaceAll('thumb', 'cover_big')}'), //${covers[index].cover?.url}
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
