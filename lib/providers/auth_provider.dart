import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? username = 'username';
  bool hidePassword = true;

  AuthProvider({this.username,});

  void changeUserName(String newUserName) {
    username = newUserName;
    notifyListeners();
  }
  void protectText(){
    hidePassword = !hidePassword;
    notifyListeners();
  }

  Future<void> register(
      {required String email, required String password}) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    username = email;
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    username = email;
    notifyListeners();
  }

  Future<void> logout() async {
    await auth.signOut();
    notifyListeners();
  }

  void changeLanguage(BuildContext context) {
    if (context.locale.toString() == 'en') {
      context.setLocale(const Locale('ar'));
    } else if (context.locale.toString() == 'ar') {
      context.setLocale(const Locale('en'));
    }
  }
}
