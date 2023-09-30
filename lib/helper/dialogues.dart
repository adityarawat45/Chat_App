import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dialogues {
  static void snackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: msg.text.make()));
  }

  static SpinKitChasingDots showprogressbar(context) {
    return SpinKitChasingDots(
      color: Vx.indigo400,
      size: 40,
    );
  }
}
