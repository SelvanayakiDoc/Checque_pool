import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/chat/chat_screen.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/login/create_an_account/creat%20an%20account.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();
  var emailKey = GlobalKey<FormState>();
  var passwordKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
   TextEditingController emailController,passwordController;
   //var email = '';
   var password = '';
   RxString userName = ''.obs;
  RxString userName1 = ''.obs;

  RxString userpassword = ''.obs;

  set email(String email) {}


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   emailController.dispose();
  //   passwordController.dispose();
  // }

  String validateEmail(String value){
    if(!GetUtils.isEmail(value))
      {
        return ' Provide Correct Email';
      }
    return null;
  }

  String validatePassword(String value){
    password = value;
    if(value.length < 6)
    {
      return ' Password must be 6 character';
    }
    return null;
  }

  Future checkLogin() async {
    final isEmail = emailKey.currentState.validate();
   final isPass=  passwordKey.currentState.validate();

   if(!isEmail && !isPass )
     {
       Get.snackbar('Warning', 'Please Fill the Email and Password',backgroundColor: Colors.red ,colorText: Colors.white);
     }
   else if(emailController.text != '' && password != null){
    CircularProgressIndicator();
    print(password);
    await _auth
        .signInWithEmailAndPassword(
      email: emailController.text, password:password, ).then((value) {
      Get.to(ChatScreen());
    }).catchError((onError){
      Get.snackbar('Warning', 'Please Check Your Email ID and Password',backgroundColor: Colors.red ,colorText: Colors.white);
      print(emailController.text);
      print(password);
      print(onError);
    });
   }
   else
     {
       Get.snackbar('Warning', '.....');
     }
    return;
  }
  Future userLogin() async{

    // Showing CircularProgressIndicator.


    // Getting value from Controller
    dynamic email = emailController.text;
    dynamic password = passwordController.text;

    // SERVER LOGIN API URL
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/userlogin';


    // Store all data with Param Name.
    var data = {'username': email, 'password' : password};

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if(response.statusCode==200)
    {
      print(response.body);

      var message = jsonDecode(response.body);
      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString('username', emailController.text.toString());
      preferences.setString('password', passwordController.text.toString());
      loginController.userName.value = emailController.text.toString();
      loginController.userpassword.value = passwordController.text.toString();
      Get.to(ProfilePage());

    }
    else{
      Get.snackbar('Warning', 'Please Check Your Email ID and Password',backgroundColor: Colors.red ,colorText: Colors.white);
      print(response.statusCode);
    }

    // Getting Server response into variable.


    // If the Response Message is Matched.

    // If Email or Password did not Matched.
    // Hiding the CircularProgressIndicator.


    // Showing Alert Dialog with Response JSON Message.


  }
}