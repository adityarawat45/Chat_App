import 'package:chat_app04/helper/dialogues.dart';
import 'package:chat_app04/main.dart';
import 'package:chat_app04/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isSigningIn = false;

  handlegooglebutton() async {
    if (mounted) {
      // Check if the widget is still mounted
      setState(() {
        _isSigningIn = true;
      });

      try {
        await _signInWithGoogle().then((user) async {
          if (mounted) {
            if (await (api.userExists())) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Homescreen()));
            } else {
              await api.createUser().then((value) => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Homescreen())));
            }
          }
        }).catchError((error) {
          print(error);
          if (mounted) {
            Dialogues.customSnackbar(context, "Oops!Something went wrong");
          }
        }).whenComplete(() {
          if (mounted) {
            setState(() {
              _isSigningIn = false;
            });
          }
        });
      } catch (e) {
        print(e);
        if (mounted) {
          setState(() {
            _isSigningIn = false;
          });
        }
      }
    }
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleauth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleauth?.accessToken,
        idToken: googleauth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Dialogues.customSnackbar(context, "Oops!Something went wrong");

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Vx.white,
        centerTitle: true,
        title: " Welcome to Doodles!"
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
              top: mq.height * .15,
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
          if (_isSigningIn) // Display the CircularProgressIndicator conditionally
            Center(
              child: SpinKitRing(
                color: Vx.blue500,
                size: 50,
              ),
            ),
        ],
      ),
    );
  }
}
