import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/user_games_services.dart';
import 'horizontal_user_lists.dart';

void showButtons(
    {required BuildContext context,
    required String gameId,
    required String userId}) {
  List<bool> isSelected = [false, false];
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.47,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.keyboard_double_arrow_down),
                ),
                const MyText(
                  text: 'Add Game',
                  size: 20,
                  weight: FontWeight.bold,
                  paddingSize: 8,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white.withOpacity(0.7),
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      child: ToggleButtons(
                        isSelected: isSelected,
                        color: Colors.grey,
                        fillColor: Colors.deepPurpleAccent,
                        splashColor: Colors.deepPurpleAccent.withOpacity(0.5),
                        selectedColor: Colors.white,
                        renderBorder: false,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        children: const [
                          MyText(
                            text: 'Favorites',
                            paddingSize: 10,
                            size: 20,
                          ),
                          MyText(
                            text: 'wishlist',
                            paddingSize: 10,
                            size: 20,
                          ),
                        ],
                        onPressed: (index) {
                          setState(
                            () {
                              if (index == 0) {
                                if (isSelected[index] == false) {
                                  addGame(gameId, 'favGames');
                                  isSelected[index] = !isSelected[index];
                                  showToastMessage(
                                      text: 'Game Added Successfully');
                                } else {
                                  removeGame(gameId, 'favGames');
                                  isSelected[index] = !isSelected[index];
                                  showToastMessage(
                                      text: 'Game Removed Successfully');
                                }
                              }
                              if (index == 1) {
                                if (isSelected[index] == false) {
                                  addGame(gameId, 'wishlist');
                                  isSelected[index] = !isSelected[index];
                                  showToastMessage(
                                      text: 'Game Added Successfully');
                                } else {
                                  removeGame(gameId, 'wishlist');
                                  isSelected[index] = !isSelected[index];
                                  showToastMessage(
                                      text: 'Game Removed Successfully');
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const MyText(
                  text: 'Your Lists',
                  paddingSize: 10,
                  weight: FontWeight.bold,
                  size: 20,
                ),
                Container(
                    height: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Center(
                        child: HorizontalUserLists(
                            gamId: gameId, myUserid: userId))),
              ],
            ),
          );
        },
      );
    },
  );
}

void showToastMessage({required text}) => Fluttertoast.showToast(
    backgroundColor: Colors.deepPurpleAccent,
    msg: text,
    fontSize: 18,
    gravity: ToastGravity.TOP);
