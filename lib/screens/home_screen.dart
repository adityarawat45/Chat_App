import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.white,
        centerTitle: true,
        leading: Icon(
          CupertinoIcons.home,
          color: Vx.indigo500,
          size: 25,
        ),
        title: "Bot Messenger"
            .text
            .size(25)
            .color(Vx.blue500)
            .fontWeight(FontWeight.normal)
            .textStyle(GoogleFonts.lilitaOne())
            .make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.search,
                color: Vx.blue500,
                size: 25,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.ellipsis_vertical,
                color: Vx.blue500,
                size: 25,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Vx.gray200,
        onPressed: () {},
        child: Icon(
          CupertinoIcons.chat_bubble_text_fill,
          color: Vx.blue500,
          size: 35,
        ),
      ),
    );
  }
}
