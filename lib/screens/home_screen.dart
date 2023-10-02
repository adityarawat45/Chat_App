import 'package:chat_app04/apis/api.dart';
import 'package:chat_app04/models/chatuser.dart';
import 'package:chat_app04/screens/profile_screen.dart';
import 'package:chat_app04/widgets/chatuser_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final API api = API();

class _HomescreenState extends State<Homescreen> {
  void initState() {
    super.initState();
    api.getselfinfo();
  }

  List<Chatuser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Vx.white,
        appBar: AppBar(
          backgroundColor: Vx.white,
          centerTitle: true,
          title: "Doodles"
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
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Profilescreen(user: api.me)));
                },
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
        body: StreamBuilder(
            stream: api.getalluser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState
                  case ConnectionState.waiting || ConnectionState.none) {
                return Center(
                  child: SpinKitThreeBounce(
                    color: Vx.blue500,
                    size: 50,
                  ),
                );
              } else if (snapshot.connectionState
                  case ConnectionState.active || ConnectionState.done) {
                final data = snapshot.data?.docs;
                list = data!.map((e) => Chatuser.fromJson(e.data())).toList();
              }
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Chatusercard(
                      user: list[index],
                    );
                  }).pOnly(top: 4);
            }));
  }
}
