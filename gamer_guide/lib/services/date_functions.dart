import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_services.dart';
import 'package:intl/intl.dart';

void datePicker({required BuildContext context}) {
  showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime(2026))
      .then((value) async {
    var date = DateFormat('MM/dd/yyyy ').format(value!);
    String myuserid = await getUserId();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myuserid)
        .get()
        .then((snapshot) => snapshot.reference.update({'DOB': date}));
  });
}

String getTime(int miliSeconds) {
  //print('$miliSeconds');
  var dt = DateTime.fromMillisecondsSinceEpoch(miliSeconds * 1000);

  var date = DateFormat('MM/dd/yyyy ').format(dt);
  return date;
}
