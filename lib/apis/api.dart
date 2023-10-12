import 'dart:io';

import 'package:chat_app04/models/chatuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class API {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  void SignOut() async {
    await auth.signOut();
    GoogleSignIn().signOut();
  }

  Future<void> updateprofile(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('profile pictures /${user.uid}');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  late Chatuser me = Chatuser(
      id: user.uid,
      image: user.photoURL.toString(),
      isactive: false,
      name: user.displayName.toString(),
      about: "Hey there,I'm using Doodles!",
      pushtoken: " ",
      createdon: " ",
      lastactive: " ",
      email: user.email.toString());
  User get user => auth.currentUser!;

  Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  Future<void> createUser() async {
    try {
      final createdtime = DateTime.now().microsecondsSinceEpoch.toString();
      final chatUser = Chatuser(
        id: user.uid,
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        isactive: false,
        lastactive: '',
        about: 'Hey there,I' "m using Doodles",
        pushtoken: '',
        createdon: createdtime,
        email: '',
      );
      await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> getselfinfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) {
      if (user.exists) {
        me = Chatuser.fromJson(user.data()!);
      } else {
        createUser().then((value) => getselfinfo());
      }
    });
  }

  Future<void> updateinfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getalluser() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
