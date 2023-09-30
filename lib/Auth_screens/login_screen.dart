import 'package:chat_app04/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool isLoaded = false;
  void initstate() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isLoaded = true;
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
          AnimatedPositioned(
              top: isLoaded ? -mq.height * .5 : mq.height * .15,
              left: mq.width * .25,
              width: mq.width * .5,
              duration: Duration(seconds: 2),
              child: Image.asset("assets/chat.png")),
          Positioned(
              width: mq.width * .9,
              left: mq.width * .06,
              height: mq.height * .06,
              bottom: mq.height * .08,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Vx.blue400,
                  ),
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/google.png",
                    height: mq.height * .03,
                  ),
                  label: "Sign in with Google"
                      .text
                      .size(16)
                      .color(Vx.white)
                      .make())),
        ],
      ),
    );
  }
}
