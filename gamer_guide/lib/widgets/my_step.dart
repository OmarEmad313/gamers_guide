import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_games.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyStep extends StatelessWidget {
  final int index;
  double rating;
  int gameId;
  final Function callBackFunction;
  final Function callBackFunction2;

  final List<GamesCoverModel> covers;
  MyStep({
    super.key,
    required this.rating,
    required this.gameId,
    required this.covers,
    required this.index,
    required this.callBackFunction,
    required this.callBackFunction2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 400,
            color: Colors.black,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 250,
              perspective: 0.005,
              diameterRatio: 2,
              /* useMagnifier: true,
              magnification: 1.25, */
              onSelectedItemChanged: (index2) {
                gameId = covers[index2].id!;
                //print(gameId);
                callBackFunction2(gameId, index);
              },
              physics: const FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: covers.length,
                builder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https:${covers[index].cover?.url?.replaceAll('thumb', 'cover_big')}'), //${covers[index].cover?.url}
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
              ),
            )),
        //star rating
        RatingBar.builder(
          initialRating: rating,
          allowHalfRating: true,
          minRating: rating,
          itemSize: 50,
          itemBuilder: (context, index) {
            return const Icon(Icons.star, color: Colors.amber);
          },
          onRatingUpdate: (value) {
            rating = value;
            callBackFunction(rating, index);
          },
        ),
      ],
    );
  }
}
