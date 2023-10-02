import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dialogues {
  Dialogues dialogues = Dialogues();
  static void customSnackbar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: msg.text.color(Vx.black).make(),

      elevation: 9.0, // Lift the snackbar up a bit
      behavior: SnackBarBehavior.floating, // Lift it further up
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Curve its border
      ),
      backgroundColor: Colors.white, // Set background color to white
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  SpinKitRing spinkit() => SpinKitRing(
        color: Vx.blue500,
        size: 50,
      );
}
