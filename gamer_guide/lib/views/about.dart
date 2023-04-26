import 'dart:async';

import 'package:flutter/material.dart';

class aboutus extends StatefulWidget {
  const aboutus({super.key});

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'What is Video Rec ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 600,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Video Rec",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      ' is a video game recommendation ',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "website launched in 2023 with a vision to create the number one destination for similar games on the web.",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'At video Recommendation we believe that there is a better way to discover video games, finding the hidden gems of experiences that make gaming such an enjoyable pass time for the millions of passionate gamers around the world. This belief guides our website principles from avoiding algorithm based tools, updating our database of games constantly, leveraging the vast gaming community and never employing slideshow page design to ensure all our suggestions are visible on a single page.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'All of our recommendations have a human touch of research and analysis which ensures that all lists feature handpicked titles of only the best similar games creating the most relevant recommendation lists on the web. This allows Games Finder to bridge the gap between the ever-growing number of video games and gamers by curating high quality lists and adding value by collating information, editorial reviews, filtering options and user ratings.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Not only has Video Rec helped a lot of gamers find their next video game title we have also been featured on the following digital properties for our reviews, games like pages and website in general.",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("privacy");
                  },
                  child: Text("Go to privacy  ")),
            ],
          ),
        ),
      ),
    );
  }
}
