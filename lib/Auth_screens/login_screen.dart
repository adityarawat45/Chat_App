import 'package:chat_app04/main.dart';
import 'package:chat_app04/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool isLoaded = false;

  handlegooglebutton() async {
    await _signInWithGoogle().then((user) {
      print(user.user);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Homescreen()));
    });
  }

  //This is the google sign in and register function,this is available on the
  //internet and you can even copy paste it from there
  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleauth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Vx.white,
        centerTitle: true,
        title: " Welcome to Bot Messenger"
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
                  onPressed: () {
                    handlegooglebutton();
                  },
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
