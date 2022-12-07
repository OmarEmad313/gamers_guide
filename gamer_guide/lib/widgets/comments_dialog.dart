import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'my_text.dart';

void show_Dialog() {
  var context;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const MyText(text: 'ADD A COMMENT', paddingSize: 0),
        //titleTextStyle: TextStyle(backgroundColor: Colors.lightBlue),
        content: SizedBox(
          height: 350,
          child: Column(
            children: [
              const MyText(
                text: 'Please leave a star rating',
                paddingSize: 8,
                weight: FontWeight.bold,
              ),
              RatingBar.builder(
                glow: true,
                glowColor: Colors.lightBlue,
                glowRadius: 2,
                minRating: 0.5,
                allowHalfRating: true,
                itemBuilder: (context, index) {
                  return const Icon(Icons.star, color: Colors.amber);
                },
                onRatingUpdate: (value) {
                  print('$value');
                },
              ),
              const SizedBox(height: 50),
              const MyText(
                  text: 'Your Comment :',
                  paddingSize: 8,
                  weight: FontWeight.bold),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0XFFD3D3D3),
                  hintText: 'Comment',
                  hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const MyText(
                      text: 'Submit',
                      paddingSize: 0,
                      weight: FontWeight.bold,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
