import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yanyuns_kitchen/query.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    final uid = FirebaseAuth.instance.currentUser!.uid;

    var userData = await getData('users', uid: uid);

    if(!userData.exists)
      {
        Map<String, dynamic> data = {
          "email": user.email,
          "displayName": user.displayName,
          "orderHistory": [],
          "cart": [],
        };

        await updateData('users', uid, data);
      }

    notifyListeners();
  }

  Future googleLogout() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
