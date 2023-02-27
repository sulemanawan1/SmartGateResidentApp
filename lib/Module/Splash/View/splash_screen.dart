import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:userapp/Routes/set_routes.dart';


import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../Login/Model/User.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    getUserSharedPreferencesData();
  }

  void getUserSharedPreferencesData() async {
    User user = await MySharedPreferences.getUserData();
    print(user.bearerToken);
    print(user.address);
    
    if (user.bearerToken == "") {
      Timer(Duration(seconds: 3), () => Get.offAndToNamed(loginscreen));
    } else if (user.address == 'NA') {
      Timer(
          Duration(seconds: 3), () => Get.offAndToNamed(residentaddressdetail));
    } else {
      Timer(Duration(seconds: 3),
          () => Get.offAndToNamed(homescreen, arguments: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Image(
          image: AssetImage('assets/mia.png'),
        )),
      ),
    );
  }
}
