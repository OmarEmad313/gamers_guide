import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/list_records_model.dart';
import 'package:flutter_application_2/services/user_lists_services.dart';
import 'package:flutter_application_2/services/user_services.dart';
import 'package:flutter_application_2/widgets/my_text.dart';

import '../services/user_games_services.dart';

void showButtons(BuildContext context, List<ListsRecordsModel> userList) {
  List<bool> isSelected = [false, false];
  List<bool> isSelected2 = [true];
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyText(
                  text: 'Add Game',
                  size: 20,
                  weight: FontWeight.bold,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: ToggleButtons(
                    isSelected: isSelected,
                    color: Colors.grey,
                    fillColor: Colors.purple,
                    splashColor: Colors.purple.withOpacity(0.4),
                    selectedColor: Colors.white,
                    renderBorder: false,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                          /* for (var i = 0; i < isSelected.length; i++) {
                            if (i == index) {
                              isSelected[i] = !isSelected[i];
                            }
                          } */
                          if (index == 0) {
                            if (isSelected[index] == false) {
                              addFavGame('2');
                              isSelected[index] = !isSelected[index];
                            } else {
                              removeFavGame('2');
                              isSelected[index] = !isSelected[index];
                            }
                          }
                          if (index == 1) {
                            if (isSelected[index] == false) {
                              addWishlistGame('2');
                              isSelected[index] = !isSelected[index];
                            } else {
                              removeWishlistGame('2');
                              isSelected[index] = !isSelected[index];
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
                /*  ToggleButtons(
                  isSelected: isSelected2,
                  color: Colors.grey,
                  fillColor: Colors.purple,
                  splashColor: Colors.purple.withOpacity(0.4),
                  selectedColor: Colors.white,
                  renderBorder: false,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  children: [
                    StreamBuilder<List<ListsRecordsModel>>(
                      stream: fetchListsRecords(userId[0]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final lists = snapshot.data;
                          return SizedBox(
                            width: 200,
                            height: 50,
                            child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return  Text(lists![0].gameId![0]);
                                }),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  ],
                  onPressed: (index) {},
                ) */
              ],
            ),
          );
        },
      );
    },
  );
}
