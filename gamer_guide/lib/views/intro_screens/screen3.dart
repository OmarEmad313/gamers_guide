import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/my_text.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.15,
              horizontal: MediaQuery.of(context).size.width * 0.1),
          decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.all(Radius.circular(60))),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const MyText(
                  text: 'Discover More Games',
                  paddingSize: 12,
                  size: 40,
                  weight: FontWeight.bold,
                ),
                Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_z0jt5alc.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
