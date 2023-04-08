import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_2/models/popular_games.dart';
import 'package:flutter_application_2/services/api_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserPreference extends StatefulWidget {
  const UserPreference({super.key});

  @override
  State<UserPreference> createState() => _UserPreferenceState();
}

class _UserPreferenceState extends State<UserPreference> {
  int currentStep = 0;
  List<GamesCoverModel> gamecovers = [];
  bool isloaded = false;

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
        print(gamecovers[0].cover!.url);
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
          title: const Text('Choose your Favorite Games'),
          centerTitle: true,
        ),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            if (currentStep == getSteps().length - 1) {
              //send data to server
              print('completed');
            } else {
              setState(() => currentStep += 1);
            }
          },
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            title: const Text('game1'),
            isActive: currentStep >= 0,
            content: Column(
              children: [
                Container(
                    height: 400,
                    color: Colors.black,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 200,
                      physics: const FixedExtentScrollPhysics(),
                      perspective: 0.006,
                      diameterRatio: 1.2,
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: gamecovers.length,
                        builder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.red,
                                width: 200,
                                child: Text(gamecovers[index].id.toString()),
                              ));
                        },
                      ),
                    )),
                //star rating
                RatingBar.builder(
                  initialRating: 0,
                  allowHalfRating: true,
                  itemSize: 50,
                  itemBuilder: (context, index) {
                    return const Icon(Icons.star, color: Colors.amber);
                  },
                  onRatingUpdate: (value) {},
                ),
              ],
            )),
        Step(
            title: const Text('game2'),
            isActive: currentStep >= 1,
            content: Container()),
        Step(
            title: const Text('game3'),
            isActive: currentStep >= 2,
            content: Container()),
      ];
}
