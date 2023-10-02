import 'package:chat_app04/main.dart';
import 'package:chat_app04/models/chatuser.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Chatusercard extends StatefulWidget {
  final Chatuser user;
  const Chatusercard({super.key, required this.user});
  @override
  State<Chatusercard> createState() => _ChatusercardState();
}

class _ChatusercardState extends State<Chatusercard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.2,
      color: Vx.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              height: mq.height * .055,
              width: mq.height * .055,
              imageUrl: widget.user.image,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  CircleAvatar(child: Icon(Icons.person_2_rounded)),
            ),
          ),
          title: widget.user.name.text.xl.make(),
          subtitle: widget.user.about.text.lg.make(),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Vx.green500,
            ),
          )

          // "12.69".text.make(),
          ),
    ).px8().pOnly(bottom: 4, top: 4);
  }
}
