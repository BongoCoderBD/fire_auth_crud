import 'dart:async';

import 'package:fire_auth_crud/ui/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth/sign_in_screen.dart';

class SplashService{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){

    Timer(const Duration(seconds: 1), ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(),), (route) => false));
    }else{
    Timer(const Duration(seconds: 1), ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false));

    }

  }
}