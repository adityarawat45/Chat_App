import 'package:chat_app04/Auth_screens/login_screen.dart';
import 'package:chat_app04/main.dart';
import 'package:chat_app04/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Loginscreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Vx.white,
        centerTitle: true,
        title: "Welcome to Bot Messenger"
            .text
            .size(25)
            .color(Vx.blue500)
            .fontWeight(FontWeight.normal)
            .textStyle(GoogleFonts.lilitaOne())
            .make(),
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              left: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset("assets/chat.png")),
          Positioned(
              width: mq.width,
              bottom: mq.height * .15,
              child: "Bot Messenger\nfor Bot people!\n🤖"
                  .text
                  .bold
                  .textStyle(GoogleFonts.inconsolata())
                  .align(TextAlign.center)
                  .size(16)
                  .color(Vx.gray900)
                  .makeCentered()),
        ],
      ),
    );
  }
}
