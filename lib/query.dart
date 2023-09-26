library query;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/styles.dart';
import 'dart:io';

Future<bool> createAccount(
    Map<String, dynamic> accountDetails, BuildContext context) async {
  bool successfulSignUp = false;
  try {
    String displayName =
        "${accountDetails['fname']} ${accountDetails['lname']}";

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: accountDetails['email']!,
            password: accountDetails['password']!)
        .then((value) async {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);

      var db = FirebaseFirestore.instance.collection(
        'users',
      );

      await db.doc(uid).set({
        "email": accountDetails['email'],
        "displayName": displayName,
        "orderHistory": [],
        "cart": [],
      });

      successfulSignUp = true;
    });
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "email-already-in-use":
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Email already in use"),
            backgroundColor: appColors['accent'],
          ),
        );
    }
  }

  return successfulSignUp;
}

Future<dynamic> getData(String collection, {var uid, var field}) async {
  var collectionRef = FirebaseFirestore.instance.collection(collection);
  late QuerySnapshot<Map<String, dynamic>> querySnapshot;
  late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  if (uid != null) {
    documentSnapshot = await collectionRef.doc(uid).get();
  }
  else {
    querySnapshot = await collectionRef
        .get();
  }


  if(uid == null) {
    List<Map<String, dynamic>> documents = [];

    for(var doc in querySnapshot.docs)
    {
      var data = doc.data();
      data['docID'] = doc.id;
      documents.add(data);
    }

    return documents;
  }


  if (field == null) {
    var data = documentSnapshot;
    return data;
  } else {
    return await documentSnapshot['$field'];
  }
}

Future<void> updateData(String collection, uid, data, {var field}) async {
  var docRef = FirebaseFirestore.instance.collection(collection).doc(uid);

  if(field != null){
    docRef.set({"$field": data}, SetOptions(merge: true));
  }
  else{
    docRef.set(data, SetOptions(merge: true));
  }
}


