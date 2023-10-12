import 'dart:io';
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
import 'package:image_picker/image_picker.dart';

class Profilescreen extends StatefulWidget {
  final Chatuser user;
  Profilescreen({super.key, required this.user});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

final formkey = GlobalKey<FormState>();
final API api = API();
final Chatuser user = api.me;
final ImagePicker picker = ImagePicker();
late String _image = "None";

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    void _showimage() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          builder: (_) {
            return ListView(
              shrinkWrap: true,
              children: [
                HeightBox(15),
                "Pick profile picture"
                    .text
                    .fontWeight(FontWeight.w400)
                    .size(18)
                    .makeCentered(),
                HeightBox(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Vx.white,
                            fixedSize: Size(80, 110)),
                        onPressed: () async {
                          // Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 80);
                          // Capture a photo.
                          if (image != null) {
                            setState(() {
                              _image = image.path;
                            });
                            api.updateprofile(File(_image));
                            Navigator.pop(context);
                          }
                        },
                        child: Image.asset("assets/addimg.png")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Vx.white,
                            fixedSize: Size(80, 110)),
                        onPressed: () async {
                          final XFile? photo = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 80);
                          setState(() {
                            _image = photo!.path;
                          });
                          api.updateprofile(File(_image));
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/camera.png")),
                  ],
                )
              ],
            );
          });
    }

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
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(children: [
                _image != "None"
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .1),
                        child: Image.file(
                          File(_image),
                          width: mq.height * .2,
                          height: mq.height * .2,
                          fit: BoxFit.cover,
                        )).pOnly(
                        top: 40,
                      )
                    : Column(
                        children: [
                          HeightBox(20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height * .1),
                            child: CachedNetworkImage(
                              imageUrl: widget.user.image,
                              width: mq.height * .2,
                              height: mq.height * .2,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ),
                            ),
                          ),
                        ],
                      ),
                Positioned(
                    child: MaterialButton(
                  onPressed: () {
                    _showimage();
                  },
                  elevation: 1,
                  shape: const CircleBorder(),
                  color: Vx.white,
                  child: Icon(
                    Icons.edit,
                    color: Vx.blue500,
                  ),
                )),
                SizedBox(
                  height: 30,
                ),
                user.email.text.color(Vx.white).makeCentered(),
                HeightBox(25),
                TextFormField(
                  onSaved: (newValue) => api.me.name = newValue ?? " ",
                  validator: (value) =>
                      value.isNotEmptyAndNotNull ? null : "Required Field!",
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
                  onSaved: (newValue) => api.me.about = newValue ?? " ",
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Required field",
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
                  height: 40,
                  width: 77,
                  text: 'Save',
                  isReverse: true,
                  selectedTextColor: Vx.white,
                  transitionType: TransitionType.LEFT_TO_RIGHT,
                  backgroundColor: Vx.orange400,
                  borderColor: Vx.orange400,
                  borderRadius: 50,
                  selectedText: "Done",
                  selectedBackgroundColor: Vx.black,
                  onPress: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      api.updateinfo();
                    }
                  },
                ),
              ]),
            ),
          ),
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
