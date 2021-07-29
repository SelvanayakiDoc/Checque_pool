import 'dart:convert';
import 'dart:io';


import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/profile/profile_controller.dart';
import 'package:flutter_app_checkque_pool/profile/profilemodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  Future<ProfileModel> _LoginModel;
  final ProfileController profileController = Get.put(ProfileController());
  bool autofocus = false;
  var docID;

  String imageUrl =
      'https://image.shutterstock.com/image-vector/default-placeholder-doctor-halflength-portrait-260nw-1061744402.jpg';

  TextEditingController _timeControllerFM = TextEditingController();
  TextEditingController _timeControllerTO = TextEditingController();
  String _hour, _minute, _time;

  String dateTime;
  var demo;
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  List<DateTime> initialSelectedDates = [];
  List time = [];
  var imageName;
  var check;
  var data;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    initialSelectedDates.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('username'+loginController.userName.toString());
    print('username'+loginController.userpassword.toString());
    _LoginModel = API().userLogin();
    initialSelectedDates.clear();
  }


  @override
  Widget build(BuildContext context) {
    Future<Null> _selectTimeFM(
        BuildContext context, StateSetter setstate) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null)
        setstate(() {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour + ' : ' + _minute;
          _timeControllerFM.text = _time;
          _timeControllerFM.text = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [hh, ':', nn, " ", am]).toString();
        });
    }

    Future<Null> _selectTimeTO(
        BuildContext context, StateSetter setstate) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null)
        setstate(() {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour + ' : ' + _minute;
          _timeControllerTO.text = _time;
          _timeControllerTO.text = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [hh, ':', nn, " ", am]).toString();
        });
    }

    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return Scaffold(
      body: FutureBuilder<ProfileModel>(
          future: _LoginModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.resultData.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.resultData[index];
                    loginController.userName1.value=article.hid;
                    // var Media= article.media[0];


                    return Container(
                      height: size.height,
                      width: size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(
                              3.0, 2.0), // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Color(0xff80D0C9),
                            Color(0xff0093E9)
                          ], // red to yellow
                          tileMode:
                          TileMode.repeated, // repeats the gradient over the canvas
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Container(
                            child: Column(
                              children: [


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30),
                                      ),
                          Stack(
                           children: [

                                Container(
                                  height: 100,
                                 width: 100,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   shape: BoxShape.circle,
                                   boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12, spreadRadius: 2)],
                                 ),

                                 child: /*(File(ProfileController.selectedImagePath.value) != null)?
                                 ClipOval(
                                     child: Image.file(File(ProfileController.selectedImagePath.value,),
                                     fit: BoxFit.cover,
                                   )):
                                     */ClipOval(
                                       child:  Image(image: NetworkImage(article.profileImg),),
                                     )
                               )/*:
                             CircularProfileAvatar(
                               '',
                               child: FlutterLogo(),
                               borderColor: Colors.purpleAccent,
                               borderWidth: 5,
                               elevation: 2,
                               radius: 50,
                             ),*/
                               /*Container(
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 shape: BoxShape.circle,
                                 boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12, spreadRadius: 2)],
                               ),
                               child: CircleAvatar(
                                 radius: 55.0,

                                 child: Image.file(File(ProfileController.selectedImagePath.value),fit: BoxFit.fill,
                                 ),
                                 //backgroundImage: AssetImage(favorites[index].imageUrl),
                               ),
                             )*/
                           ,
                             Positioned(
                                 top:60,
                                 left:60,
                                 child: IconButton(
                                   onPressed: (){
                                     print('image pick');
                                     showDialog(context: context, builder: (BuildContext context) {
                                       return new AlertDialog(
                                         title: new Text("Choose to your profile picture",textAlign: TextAlign.center,),

                                         content: Container(
                                           height: 60,
                                           width: 50,
                                           decoration: BoxDecoration(
                                               color: Colors.blue,
                                               border: Border.all(
                                                   color: Colors.white, // Set border color
                                                   ),   // Set border width
                                               borderRadius: BorderRadius.all(
                                                   Radius.circular(10.0)), // Set rounded corner radius
                                               boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                                           ),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               IconButton(onPressed: (){
                                                 ProfileController.getImage(ImageSource.camera);
                                               }, icon: Icon(Icons.camera)),
                                               IconButton(onPressed: (){
                                                 ProfileController.getImage(ImageSource.gallery);
                                               }, icon: Icon(Icons.image)),
                                             ],
                                           ),
                                         ),
                                       );
                                     });
                                     //Get.to(()=>bottomSheet());
                                   },
                                     icon: Icon(
                                       Icons.image,
                                       color: Colors.white,
                             )))
                           ],
                          ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 20,top: 6),
                                        child: ListTile(
                                          title: profileController.autofocusName ==
                                              true
                                              ? TextFormField(
                                            textInputAction:
                                            TextInputAction.next,
                                            onEditingComplete: () =>
                                                node.nextFocus(), //
                                            controller: profileController
                                                .nameController,
                                            autofocus:
                                            profileController.autofocusName,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: article.name,
                                              hintStyle: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: Colors.blue,
                                              ),
                                              suffixStyle: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            style:
                                            TextStyle(color: Colors.black),
                                          )
                                              : Text(article.name,style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          subtitle: Text(article.city??''),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                setState(() {
                                                  profileController.autofocusName =
                                                  true;
                                                  profileController.saveButton = true;
                                                });
                                                setState(() {
                                                    profileController.autofocusName =
                                                        true;
                                                    profileController.saveButton = true;

                                                });
                                              //   showState(() {
                                              //   profileController.autofocusName =
                                              //       true;
                                              //   profileController.saveButton = true;
                                              // });
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                                  child: Container(
                                    height: size.height * 0.09,
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(25.0))),
                                    child: ListTile(
                                      title: profileController.autofocusPhone ==
                                          true
                                          ? TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(), //
                                        controller: profileController.phoneNumController,
                                        autofocus:
                                        profileController.autofocusPhone,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: "Phone\*",
                                          hintStyle: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.blue,
                                          ),
                                          suffixStyle: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      )
                                          : Text(article.mbl),
                                      subtitle: Text(
                                        'Mobile',
                                        style:
                                        TextStyle(fontSize: size.width * 0.03),
                                      ),
                                      leading: Icon(Icons.phone),
                                      trailing: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            setState(() {
                                              profileController.autofocusPhone =
                                              true;
                                              profileController.saveButton = true;

                                            });
                                            /*showState(() {
                                            profileController.autofocusPhone =
                                                true;
                                            profileController.saveButton = true;
                                          });*/
                                          }),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.09,
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(25.0))),
                                    child: ListTile(
                                      title: profileController.autofocusDoctorID ==
                                          true
                                          ? TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(), //
                                        controller: profileController
                                            .doctorIDController,
                                        autofocus: profileController
                                            .autofocusDoctorID,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: "doctorID\*",
                                          hintStyle: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.blue,
                                          ),
                                          suffixStyle: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      )
                                          : Text(article.euid),
                                      subtitle: Text(
                                        'doctorID',
                                        style:
                                        TextStyle(fontSize: size.width * 0.03),
                                      ),
                                      leading: Icon(Icons.person_outline_outlined),
                                      trailing: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            setState(() {
                                              profileController.autofocusDoctorID =
                                              true;
                                              profileController.saveButton = true;

                                            });
                                            /* showState(() {
                                            profileController.autofocusDoctorID =
                                                true;
                                            profileController.saveButton = true;
                                          });*/
                                          }),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.09,
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(25.0))),
                                    child: ListTile(
                                      title: profileController.autofocusEmail ==
                                          true
                                          ? TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(), //
                                        controller:
                                        profileController.hospitalController,
                                        autofocus:
                                        profileController.autofocusEmail,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: "hospitalID\*",
                                          hintStyle: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.blue,
                                          ),
                                          suffixStyle: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      )
                                          : Text(article.hid),
                                      subtitle: Text(
                                        'hospitalID',
                                        style:
                                        TextStyle(fontSize: size.width * 0.03),
                                      ),
                                      leading: Icon(Icons.email_outlined),
                                      trailing: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            setState(() {
                                              profileController.autofocusEmail =
                                              true;
                                              profileController.saveButton = true;

                                            });
                                          /*  showState(() {
                                            profileController.autofocusEmail =
                                                true;
                                            profileController.saveButton = true;
                                          });*/
                                          }),
                                    ),
                                  ),
                                ),
                                /*Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
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
                                fontSize: size.width* 0.02,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),*/
                               /* Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.09,
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(25.0))),
                                    child: ListTile(
                                      title: profileController.autofocusHospital ==
                                          true
                                          ? TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(), //
                                        controller: profileController
                                            .hospitalController,
                                        autofocus: profileController
                                            .autofocusHospital,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: "Hospital\*",
                                          hintStyle: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.blue,
                                          ),
                                          suffixStyle: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      )
                                          : Text(article.ttl),
                                      subtitle: Text(
                                        'Mobile',
                                        style:
                                        TextStyle(fontSize: size.width * 0.03),
                                      ),
                                      leading: Icon(Icons.local_hospital),
                                      trailing: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            setState(() {
                                              profileController.autofocusHospital =
                                              true;
                                              profileController.saveButton = true;

                                            });
                                            *//*showState(() {
                                            profileController.autofocusHospital =
                                                true;
                                            profileController.saveButton = true;
                                          });*//*
                                          }),
                                    ),
                                  ),
                                ),*/
                                /*Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.09,
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(25.0))),
                                    child: ListTile(
                                      title: profileController.autofocusClinic ==
                                          true
                                          ? TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(), //
                                        controller: profileController
                                            .clinicController,
                                        autofocus:
                                        profileController.autofocusClinic,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: "Clinic\*",
                                          hintStyle: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.blue,
                                          ),
                                          suffixStyle: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      )
                                          : Text('clinic'),
                                      subtitle: Text(
                                        'Clinic',
                                        style:
                                        TextStyle(fontSize: size.width * 0.03),
                                      ),
                                      leading: Icon(Icons.local_hospital),
                                      trailing: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            setState(() {
                                              profileController.autofocusClinic =
                                              true;
                                              profileController.saveButton = true;

                                            });
                                            *//*showState(() {
                                            profileController.autofocusClinic =
                                                true;
                                            profileController.saveButton = true;
                                          });*//*
                                          }),
                                    ),
                                  ),
                                ),*/
                                /*Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.09,
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(25.0))),
                                    child: ListTile(
                                      title: profileController
                                          .autofocusSpecializedIn ==
                                          true
                                          ? TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(), //
                                        controller: profileController
                                            .specialisedController,
                                        autofocus: profileController
                                            .autofocusSpecializedIn,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: "specializedIn\*",
                                          hintStyle: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.blue,
                                          ),
                                          suffixStyle: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      )
                                          : Text('specializedIn'),
                                      subtitle: Text(
                                        'specializedIn',
                                        style:
                                        TextStyle(fontSize: size.width * 0.03),
                                      ),
                                      leading: Icon(Icons.filter_alt_outlined),
                                      *//*trailing: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            setState(() {
                                              profileController
                                                  .autofocusSpecializedIn = true;
                                              profileController.saveButton = true;
                                            });
                                            *//**//*showState(() {
                                            profileController
                                                .autofocusSpecializedIn = true;
                                            profileController.saveButton = true;
                                          });*//**//*
                                          }),*//*
                                    ),
                                  ),
                                ),*/
                                /*Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  Container(
                                      height: size.height * 0.09,
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(25.0))),
                                      child: ListTile(
                                        title: Text('Appointments'),
                                        subtitle: Text(
                                          'Doctor Appointments',
                                          style:
                                          TextStyle(fontSize: size.width * 0.03),
                                        ),
                                        leading: Icon(Icons.calendar_today),
                                      *//* trailing: IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                               setState(() {
                                              print(
                                                  'initobs $initialSelectedDates');
                                              Get.defaultDialog(
                                                  title: 'Appointments',
                                                  content: StatefulBuilder(builder:
                                                      (context,
                                                          StateSetter setstate) {
                                                    return Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                _selectTimeFM(
                                                                    context,
                                                                    setstate);
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width:
                                                                          size.width *
                                                                              .005),
                                                                  Text(
                                                                    'FM-',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.05),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          size.width *
                                                                              .01),
                                                                  _timeControllerFM
                                                                              .text ==
                                                                          ''
                                                                      ? Text(
                                                                          ' Time',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  size.width * 0.05),
                                                                        )
                                                                      : Text(
                                                                          _timeControllerFM
                                                                              .text,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  size.width * 0.05),
                                                                        ),
                                                                  SizedBox(
                                                                      width:
                                                                          size.width *
                                                                              .005),
                                                                  Text(
                                                                    '--',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.05),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                _selectTimeTO(
                                                                    context,
                                                                    setstate);
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width:
                                                                          size.width *
                                                                              .005),
                                                                  Text(
                                                                    'TO --',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.05),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          size.width *
                                                                              .01),
                                                                  _timeControllerTO
                                                                              .text ==
                                                                          ''
                                                                      ? Text(
                                                                          ' Time',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  size.width * 0.05),
                                                                        )
                                                                      : Text(
                                                                          _timeControllerTO
                                                                              .text,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  size.width * 0.05),
                                                                        ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.end,
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    Text('Cancel')),
                                                            TextButton(
                                                                onPressed: () {},
                                                                child:
                                                                    Text('Save')),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }));
                                            });
                                            }),*//*
                                      ),

                                  ),
                                ),*/
                                profileController.saveButton == true
                                    ? Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 16.0),
                                  child: Material(
                                    elevation: 5.0,
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: MaterialButton(
                                      onPressed: () {
                                        update();
                                      },
                                      minWidth: 120,
                                      height: 42.0,
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ),

                        ),
                      ),


                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());

      }),
    );
  }
}
class API{
  Future<ProfileModel> userLogin() async {
    //print('loginController.userName.toString(), ${loginController.userName.toString()}');
    var newsModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/doctor';
    var data = {
      'id': loginController.userName.toString(),
      // 'password': loginController.userpassword.toString()
    };
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if (response.statusCode == 200) {
      //print(response.body);


      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);

      newsModel = ProfileModel.fromJson(jsonMap);
      return newsModel;
      print(newsModel);

    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }




  }}
Future update() async {
  print('hospital_id: ${profileController.hospitalController.text}');
  print('name: ${profileController.nameController.text}');
  print('mobile: ${profileController.phoneNumController.text}');
  print('doctor_id: ${profileController.doctorIDController.text}');

  var url = 'https://www.docllpdemo.com/checkpool/api/dapi/docup';
  //var byte=ProfileController.selectedImagePath.value;
  var postUri = Uri.parse(url);
  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file', ProfileController.selectedImagePath.value);
  request.fields["hospital_id"] = profileController.hospitalController.text;
  request.fields["name"] = profileController.nameController.text;
  request.fields["mobile"] = profileController.phoneNumController.text;
  request.fields["doctor_id"] = profileController.doctorIDController.text;
  request.files.add(multipartFile);
  http.StreamedResponse response = await request.send();
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.request);
    Get.snackbar('Done','Your Profile has been updated',backgroundColor: Colors.green ,colorText: Colors.white);
  }
  else
  {
    print('response.statusCode ${response.statusCode}');
    Get.snackbar('Oops!','Something Went Wrong',backgroundColor: Colors.red ,colorText: Colors.white);

  }




}

/*Widget bottomSheet() {
  return Scaffold(
    body: Container(
      height: 100.0,
      width: 500,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
               //takePhoto(ImageSource.camera);
                ProfileController.getImage(ImageSource.camera);

              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
               // takePhoto(ImageSource.gallery);
                ProfileController.getImage(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    ),
  );
}*/



/*
void takePhoto(ImageSource source) async {
  final pickedFile = await _picker.getImage(
    source: source,
  );
  setState(() {
    _imageFile = pickedFile;
  });
}*/
