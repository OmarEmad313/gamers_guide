import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/dialog_button.dart';
import 'package:flutter_application_2/widgets/text_form_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../services/user_comments_services.dart';
import 'my_button.dart';
import 'my_text.dart';

void showcommentdialog(BuildContext context, String gameId) async {
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double rating = 0.5;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const MyText(text: 'ADD A COMMENT'),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.375,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Divider(color: Colors.black, height: 25),
                    const MyText(
                      text: 'Please leave a star rating',
                      paddingSize: 8,
                      weight: FontWeight.bold,
                    ),
                    RatingBar.builder(
                      glow: true,
                      glowColor: Colors.deepPurple,
                      glowRadius: 2,
                      minRating: 0.5,
                      initialRating: 0.5,
                      allowHalfRating: true,
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (value) =>
                          //print('$value');
                          setState(() {
                        rating = value;
                        //print(rating);
                      }),
                    ),
                    const SizedBox(height: 50),
                    const MyText(
                        text: 'Your Comment :',
                        paddingSize: 8,
                        weight: FontWeight.bold),
                    MyTextFormField(
                      text: 'Comment',
                      controller: commentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a comment';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              DialogButton(
                  text: 'Submit',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      createComment(
                          gameId: gameId,
                          rating: rating,
                          comment: commentController.text);
                      Navigator.pop(context);
                    }
                  })
            ],
          );
        },
      );
    },
  );
}
