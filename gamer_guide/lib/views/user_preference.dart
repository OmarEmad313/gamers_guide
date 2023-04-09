// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_games.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_application_2/widgets/my_button.dart';
import 'package:flutter_application_2/widgets/my_step.dart';
import 'package:go_router/go_router.dart';

class UserPreference extends StatefulWidget {
  const UserPreference({super.key});

  @override
  State<UserPreference> createState() => _UserPreferenceState();
}

class _UserPreferenceState extends State<UserPreference> {
  int currentStep = 0;
  List<GamesCoverModel> gamecovers = [];
  bool isloaded = false;

  List<double> gameRatings = [0.5, 0.5, 0.5, 0.5, 0.5];
  List<int> gameIds = [0, 0, 0, 0, 0];

  callback(gameRating, index) {
    setState(() {
      if (index == 1) {
        gameRatings[0] = gameRating;
      }
      if (index == 2) {
        gameRatings[1] = gameRating;
      }
      if (index == 3) {
        gameRatings[2] = gameRating;
      }
      if (index == 4) {
        gameRatings[3] = gameRating;
      } else {
        gameRatings[4] = gameRating;
      }
    });
  }

  callback2(gameId, index) {
    setState(() {
      if (index == 1) {
        gameIds[0] = gameId;
      }
      if (index == 2) {
        gameIds[1] = gameId;
      }
      if (index == 3) {
        gameIds[2] = gameId;
      }
      if (index == 4) {
        gameIds[3] = gameId;
      } else {
        gameIds[4] = gameId;
      }
    });
  }

  @override
  void initState() {
    mainFunction();
    super.initState();
  }

  Future<void> mainFunction() async {
    gamecovers = await GameServices.userPreferenceGames();

    if (gamecovers.isNotEmpty) {
      setState(() {
        isloaded = true;
        //print(gamecovers[0].cover!.url);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isloaded,
      replacement: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              context.go('/home/1');
            },
          ),
          title: const Text('Choose your Favorite Games'),
          centerTitle: true,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: Colors.deepPurple)),
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepTapped: (step) => setState(() => currentStep = step),
            controlsBuilder: (context, details) {
              return Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: currentStep == getSteps().length - 1
                          ? 'Confirm'
                          : 'Next',
                      horizontalPadding: 15,
                      onPressed: () {
                        if (currentStep == getSteps().length - 1) {
                          //send data to server
                          print(
                              gameIds[0] == 0 ? gamecovers[0].id : gameIds[0]);
                          print(gameIds[1]);
                          print(gameIds[2]);
                          print(gameIds[3]);
                          print(gameIds[4]);
                        } else {
                          setState(() => currentStep += 1);
                          //gamecovers.removeAt(0);
                          for (var i = 0; i < gameIds.length; i++) {
                            gamecovers.removeWhere((object) {
                              return object.id == gameIds[i];
                            });
                          }
                          //gamecovers.removeAt(0);
                          print(gamecovers.length);
                        }
                      },
                    ),
                    if (currentStep != 0)
                      MyButton(
                          text: 'Back',
                          horizontalPadding: 15,
                          color: Colors.red,
                          onPressed: () => setState(() => currentStep -= 1))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          title: const Text(''),
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          content: MyStep(
            gameId: gameIds[0],
            rating: gameRatings[0],
            covers: gamecovers,
            index: 1,
            callBackFunction: callback,
            callBackFunction2: callback2,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          content: MyStep(
            gameId: gameIds[1],
            rating: gameRatings[1],
            covers: gamecovers,
            index: 2,
            callBackFunction: callback,
            callBackFunction2: callback2,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 2,
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          content: MyStep(
            gameId: gameIds[2],
            rating: gameRatings[2],
            covers: gamecovers,
            index: 3,
            callBackFunction: callback,
            callBackFunction2: callback2,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 3,
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          content: MyStep(
            gameId: gameIds[3],
            rating: gameRatings[3],
            covers: gamecovers,
            index: 4,
            callBackFunction: callback,
            callBackFunction2: callback2,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 4,
          content: MyStep(
            gameId: gameIds[4],
            rating: gameRatings[4],
            covers: gamecovers,
            index: 5,
            callBackFunction: callback,
            callBackFunction2: callback2,
          ),
        ),
      ];
}
