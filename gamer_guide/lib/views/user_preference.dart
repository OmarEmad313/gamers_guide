// ignore_for_file: non_constant_identifier_names

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

  int game1_id = 0;
  int game2_id = 0;
  int game3_id = 0;
  int game4_id = 0;
  int game5_id = 0;
  double rating1 = 0.5;
  double rating2 = 0.5;
  double rating3 = 0.5;
  double rating4 = 0.5;
  double rating5 = 0.5;
  List<double> gameRatings = [];
  List<int> gameIds = [];

  callback(gameRating, gameId) {
    setState(() {
      gameRatings.add(gameRating);
      gameIds.add(gameId);
    });
  }

  callback2(arg) {
    setState(() {
      rating1 = arg;
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
                          print(game1_id == 0 ? gamecovers[0].id : game1_id);
                          print(gameRatings);
                          print(gameIds);
                        } else {
                          setState(() => currentStep += 1);
                          //gamecovers.removeAt(0);
                          gamecovers.removeWhere((object) {
                            //print(game1_id);
                            return object.id == game1_id;
                          });
                          //print(gamecovers.length);
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
            gameId: game1_id,
            rating: rating1,
            covers: gamecovers,
            callBackFunction: callback,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          content: MyStep(
            gameId: game2_id,
            rating: rating2,
            covers: gamecovers,
            callBackFunction: callback,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 2,
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          content: MyStep(
            gameId: game3_id,
            rating: rating3,
            covers: gamecovers,
            callBackFunction: callback,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 3,
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          content: MyStep(
            gameId: game4_id,
            rating: rating4,
            covers: gamecovers,
            callBackFunction: callback,
          ),
        ),
        Step(
          title: const Text(''),
          isActive: currentStep >= 4,
          content: MyStep(
            gameId: game5_id,
            rating: rating5,
            covers: gamecovers,
            callBackFunction: callback,
          ),
        ),
      ];
}
