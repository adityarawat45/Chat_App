import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Chatusercard extends StatefulWidget {
  const Chatusercard({super.key});

  @override
  State<Chatusercard> createState() => _ChatusercardState();
}

class _ChatusercardState extends State<Chatusercard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.2,
      color: Color.fromARGB(255, 229, 234, 250),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage("assets/puneet.jpg"),
        ),
        title: "Lord Puneet".text.xl.make(),
        subtitle: "Bekar hai bhaiya,m to toot gaya! 🫡".text.lg.make(),
        trailing: "12.69".text.make(),
      ),
    ).px8().pOnly(bottom: 4, top: 4);
  }
}
