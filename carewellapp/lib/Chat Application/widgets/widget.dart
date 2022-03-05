import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

PreferredSizeWidget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.blue[700],
    title: new Text("Carewell"),
  );
}
