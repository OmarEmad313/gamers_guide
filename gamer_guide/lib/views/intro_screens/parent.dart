import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/intro_screens/screen1.dart';
import 'package:flutter_application_2/views/intro_screens/screen2.dart';
import 'package:flutter_application_2/views/intro_screens/screen3.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:go_router/go_router.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ParentsIntroScreen extends StatefulWidget {
  const ParentsIntroScreen({super.key});

  @override
  State<ParentsIntroScreen> createState() => _ParentsIntroScreenState();
}

class _ParentsIntroScreenState extends State<ParentsIntroScreen> {
  PageController pageController = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              index == 2 ? onLastPage = true : false;
            });
          },
          controller: pageController,
          children: const [Screen1(), Screen2(), Screen3()],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              alignment: const Alignment(0, 0),
              decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    text: 'Skip',
                    onPressed: () {
                      pageController.jumpToPage(2);
                    },
                  ),
                  SmoothPageIndicator(controller: pageController, count: 3),
                  onLastPage
                      ? MyButton(
                          text: 'Done',
                          onPressed: () {
                            context.go('/home/0');
                          },
                        )
                      : MyButton(
                          text: 'Next',
                          onPressed: () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                        )
                ],
              )),
        )
      ]),
    );
  }
}
