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

//for search panel
  final List<Chatuser> _searchlist = [];
  bool _isSearching = false;
  List<Chatuser> list = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            backgroundColor: Vx.white,
            appBar: AppBar(
              backgroundColor: Vx.white,
              centerTitle: true,
              title: _isSearching
                  ? TextField(
                      onChanged: (value) {
                        _searchlist.clear();
                        for (var i in list) {
                          if (i.name.contains(value.toLowerCase()) ||
                              i.email.contains(value.toLowerCase())) {
                            _searchlist.add(i);
                          }
                          setState(() {
                            _searchlist;
                          });
                        }
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name,E-mail...🔍"),
                    )
                  : "Doodles"
                      .text
                      .size(25)
                      .color(Vx.blue500)
                      .fontWeight(FontWeight.normal)
                      .textStyle(GoogleFonts.lilitaOne())
                      .make(),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                    icon: _isSearching
                        ? Icon(
                            CupertinoIcons.search_circle_fill,
                            color: Vx.blue500,
                            size: 25,
                          )
                        : Icon(
                            CupertinoIcons.search_circle,
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
                    list =
                        data!.map((e) => Chatuser.fromJson(e.data())).toList();
                  }
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount:
                          _isSearching ? _searchlist.length : list.length,
                      itemBuilder: (context, index) {
                        return Chatusercard(
                          user: _isSearching ? _searchlist[index] : list[index],
                        );
                      }).pOnly(top: 4);
                })),
      ),
    );
  }
}
