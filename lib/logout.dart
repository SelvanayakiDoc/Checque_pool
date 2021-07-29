import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/login/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            Alignment(5.0, 2.0), // 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xff80D0C7),
              Color(0xff0093E9)
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                      Get.back();

                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 250),
                child: Material(
                  elevation: 5.0,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.remove('username');
                      preferences.remove('password');
                      Get.to(LoginPage());
                      },
                    minWidth: 70,
                    height: 52.0,
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        //fontSize: size.width* 0.03,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
