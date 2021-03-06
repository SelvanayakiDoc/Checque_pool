import 'package:flutter/material.dart';
// import 'package:flutter_app_checkque_pool/chat/chat_screen.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:flutter_app_checkque_pool/login/login_controller.dart';
// import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
// import 'package:flutter_app_checkque_pool/utills/UserSimplePreference.dart';
import 'package:get/get.dart';
import 'create_an_account/creat an account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';



class LoginPage extends StatefulWidget {
  // const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController profileController = Get.put(LoginController());


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberme = false;
  bool isCheck = false;






  bool secureText = true;
  bool showSpinner = false;
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
      // var message = jsonDecode(response.body);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('username', emailController.text.toString());
      preferences.setString('password', passwordController.text.toString());
      loginController.userName.value = emailController.text.toString();
      Get.to(SidebarPage());


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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 85.0,bottom: 25.0),
                child: PhotoHero(
                  photo:  "assets/cp-logo.png",
                  width: size.width * 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                //  key: loginController.emailKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(), //

                      controller:emailController,
                      onSaved: (value){
                        loginController.email = value;
                      },
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "User ID\*",
                        hintStyle: TextStyle(
                          fontSize: size.width* 0.04,
                          color:Colors.blue,
                        ),
                        suffix: Text('User ID'),
                        suffixStyle: TextStyle(
                          fontSize: size.width* 0.03,
                          color:Colors.blue,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 10),
                child: Form(
                  //key: loginController.passwordKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(), //
                      controller: passwordController,
                      validator: (String value){
                        return loginController.validatePassword(value);
                      },
                      obscureText: true,
                      onSaved: (value){
                        loginController.password = value;
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Password\*" ,
                          hintStyle: TextStyle(
                            fontSize: size.width* 0.04,
                            color: Colors.blue,
                          ),
                          suffixText: 'Password',
                          suffixStyle: TextStyle(
                            fontSize: size.width* 0.03,
                            color:Colors.blue,
                          ),
                          focusColor: Colors.white),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),


                ),
              ),

                      Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0,right: 35.0),
                    child: Row(

                      children: [

                        Checkbox(
                          value: isCheck,
                          checkColor: Colors.blue,  // color of tick Mark
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() async {
                              isCheck = value;
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              preferences.setString('remember me', passwordController.text.toString());
                            });
                            },

                        ),
                      Text('Remember me'),

                        Spacer(),
                        TextButton(
                          onPressed: (){}, child: Text(
                          'Forgot Password?',style: TextStyle(color: Colors.black),
                        ),),
                        // Text('Forgot Password?')



                        // Text("Remember me"),
                        // Spacer(),
                        // Text("Forgot Password?"),

                      ],

                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 36.0),
                        child: Material(
                          elevation: 5.0,
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () async {
                              Get.to(CreateAnAccount());
                              // setState(() {
                              //   showSpinner = true;
                              // });
                              // try {
                              //   print(emailController.text);
                              //   print(passwordController.text);
                              //   await _auth
                              //       .signInWithEmailAndPassword(
                              //     email: emailController.text, password:passwordController.text, )
                              //       .then((signedInUser) async{
                              //     // Navigator.pushReplacementNamed(context, 'SP');
                              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SidebarPage()));
                              //   }).catchError((e) {
                              //     print(e);
                              //     var snackbar = SnackBar(
                              //         content: Text(
                              //             'Email ID and password is incorrect please check the user name and password....'));
                              //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              //   }); //Go to login screen.
                              //
                              //   setState(() {
                              //     showSpinner = false;
                              //     emailKey.currentState.validate();
                              //     passwordKey.currentState.validate();
                              //     // nameKey.currentState.validate();
                              //     passwordController.clear();
                              //   });
                              // } catch (e) {
                              //   print(e);
                              // }
                              // passwordController.clear();
                            },
                            minWidth: 120,
                            height: 42.0,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: size.width* 0.05,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          elevation: 5.0,
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () async {
                             userLogin();
                              // setState(() {
                              //   showSpinner = true;
                              // });
                              // try {
                              //   print(emailController.text);
                              //   print(passwordController.text);
                              //   await _auth
                              //       .signInWithEmailAndPassword(
                              //     email: emailController.text, password:passwordController.text, )
                              //       .then((signedInUser) async{
                              //     // Navigator.pushReplacementNamed(context, 'SP');
                              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SidebarPage()));
                              //   }).catchError((e) {
                              //     print(e);
                              //     var snackbar = SnackBar(
                              //         content: Text(
                              //             'Email ID and password is incorrect please check the user name and password....'));
                              //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              //   }); //Go to login screen.
                              //
                              //   setState(() {
                              //     showSpinner = false;
                              //     emailKey.currentState.validate();
                              //     passwordKey.currentState.validate();
                              //     // nameKey.currentState.validate();
                              //     passwordController.clear();
                              //   });
                              // } catch (e) {
                              //   print(e);
                              // }
                              // passwordController.clear();
                            },
                            minWidth: 120,
                            height: 42.0,
                            child: Text(
                              'Log In',
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
                  // Align(
                  //   alignment: Alignment.center,
                  //   Padding(
                  //     padding: const EdgeInsets.all(20),
                  //      Column(
                  //       children: [
                  //         TextButton(
                  //           onPressed: (){}, child: Text(
                  //           'Forgot Password?',style: TextStyle(color: Colors.black),
                  //         ),),

                    ]),




            ],
          ),
        ),
      ),
    );
  }
}
