import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:lottie/lottie.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.all(Radius.circular(60))),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 48, 48, 48),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const MyText(
                  text: 'Connect With Others !!',
                  paddingSize: 10,
                  size: 40,
                  weight: FontWeight.bold,
                ),
                Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_olqvwn7h.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
