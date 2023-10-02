import 'package:chat_app04/models/chatuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class API {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void SignOut() async {
    await auth.signOut();
    GoogleSignIn().signOut();
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getalluser() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
