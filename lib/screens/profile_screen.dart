import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app04/Auth_screens/login_screen.dart';
import 'package:chat_app04/apis/api.dart';
import 'package:chat_app04/main.dart';
import 'package:chat_app04/models/chatuser.dart';
import 'package:chat_app04/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Profilescreen extends StatefulWidget {
  final Chatuser user;
  Profilescreen({super.key, required this.user});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

final API api = API();
final Chatuser user = api.me;

class _ProfilescreenState extends State<Profilescreen> {
  // List<Chatuser> list = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Vx.blue500,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Homescreen()));
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Vx.blue500,
                  size: 25,
                )),
            // elevation: 1,
            backgroundColor: Vx.white,
            centerTitle: true,
            title: "Profile"
                .text
                .size(25)
                .color(Vx.blue500)
                .fontWeight(FontWeight.normal)
                .textStyle(GoogleFonts.lilitaOne())
                .make(),
          ),
          body: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .1),
              child: CachedNetworkImage(
                height: mq.height * .2,
                width: mq.height * .2,
                fit: BoxFit.fill,
                imageUrl: user.image,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    CircleAvatar(child: Icon(Icons.person_2_rounded)),
              ),
            ).pOnly(
              top: 40,
            ),
            SizedBox(
              height: 30,
            ),
            user.email.text.color(Vx.white).makeCentered(),
            HeightBox(25),
            TextFormField(
              initialValue: widget.user.name,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Vx.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Vx.white,
                        width: 3.0), // Color when the field is in focus
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Vx.white, width: 2.0), // Default color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "eg : John Doe",
                  prefixIcon: Icon(
                    CupertinoIcons.person_solid,
                    color: Vx.gray600,
                    size: 25,
                  ),
                  border: OutlineInputBorder(
                      gapPadding: Checkbox.width,
                      borderRadius: BorderRadius.circular(10))),
            ).px32(),
            HeightBox(32),
            TextFormField(
              initialValue: widget.user.about,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Vx.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Vx.white,
                        width: 3.0), // Color when the field is in focus
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Vx.white, width: 1.0), // Default color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // alignLabelWithHint: true,
                  hintText: "Hey there,I'm using Doodles",
                  // labelText: "About",
                  prefixIcon: Icon(
                    CupertinoIcons.info_circle_fill,
                    color: Vx.gray600,
                    size: 25,
                  ),
                  border: OutlineInputBorder(
                      gapPadding: Checkbox.width,
                      borderRadius: BorderRadius.circular(10))),
            ).px32(),
            HeightBox(30),
            AnimatedButton(
              height: 50,
              width: 87,
              text: 'Save',
              isReverse: true,
              selectedTextColor: Vx.white,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              backgroundColor: Vx.orange400,
              borderColor: Vx.orange400,
              borderRadius: 50,
              selectedText: "Done",
              selectedBackgroundColor: Vx.black,
              onPress: () {},
            ),
          ]),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Vx.orange400,
            onPressed: () {
              api.SignOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const Loginscreen()));
            },
            label: "Log out".text.make(),
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: Vx.white,
            ),
          )),
    );
  }
}
