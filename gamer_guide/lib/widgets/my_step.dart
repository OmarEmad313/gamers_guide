import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_games.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyStep extends StatefulWidget {
  final int index;

  final Function callBackFunction;
  final Function callBackFunction2;

  final List<GamesCoverModel> covers;
  MyStep({
    super.key,
    required this.covers,
    required this.index,
    required this.callBackFunction,
    required this.callBackFunction2,
  });

  @override
  State<MyStep> createState() => _MyStepState();
}

class _MyStepState extends State<MyStep> {
  int gameId = 0;
  double rating = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.47,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: ListWheelScrollView.useDelegate(
              itemExtent: MediaQuery.of(context).size.height * 0.33,
              perspective: 0.005,
              diameterRatio: 2,
              /* useMagnifier: true,
              magnification: 1.25, */
              onSelectedItemChanged: (index2) {
                gameId = widget.covers[index2].id!;
                //print(gameId);
                widget.callBackFunction2(gameId, widget.index);
              },
              physics: const FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: widget.covers.length,
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
                                'https:${widget.covers[index].cover?.url?.replaceAll('thumb', 'cover_big')}'), //${covers[index].cover?.url}
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
              ),
            )),
        //star rating
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: RatingBar.builder(
            glow: true,
            glowColor: Colors.deepPurple,
            glowRadius: 10,
            initialRating: rating,
            minRating: rating,
            itemSize: 50,
            itemBuilder: (context, index) {
              return const Icon(Icons.star, color: Colors.amber);
            },
            onRatingUpdate: (value) {
              rating = value;
              widget.callBackFunction(rating, widget.index);
            },
          ),
        ),
      ],
    );
  }
}
