import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/complete_appointments/own_appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/new_appointments/new_appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointmentController.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointments.dart';
import 'package:flutter_app_checkque_pool/chat/chat_screen.dart';
import 'dart:math' as math show pi;

import 'package:flutter_app_checkque_pool/doctor_panel/doctor_panel.dart';
import 'package:flutter_app_checkque_pool/login/login.dart';
import 'package:flutter_app_checkque_pool/logout.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem> _items;
  int _headline;
  NetworkImage _avatarImg =
  NetworkImage('https://www.w3schools.com/howto/img_avatar.png');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    // _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Profile',
        icon: Icons.person,
        onPressed: () => setState(() => _headline = 0),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Doctor Panel',
        icon: Icons.assessment,
        onPressed: () => setState(() => _headline = 1),
        // isSelected: true,
      ),
      CollapsibleItem(
        text: 'Appointments',
        icon: Icons.calendar_today,
        onPressed: () => setState(() => _headline = 2),
      ),
      CollapsibleItem(
        text: 'Completed Appointments',
        icon: Icons.calendar_today,
        onPressed: () => setState(() =>_headline = 4),
      ),
      CollapsibleItem(
        text: 'New Appointments',
        icon: Icons.calendar_today,
        onPressed: () => setState(() => Get.to(NewAppointments())),
      ),

      CollapsibleItem(
        text: 'Pending Appointments',
        icon: Icons.calendar_today,
        onPressed: () => setState(() => _headline = 3),
      ),
      // CollapsibleItem(
      //   text: 'Navigation Items',
      //   icon: Icons.navigation,
      //   onPressed: () => setState(() => _headline =6),
      // ),
      CollapsibleItem(
        text: 'Settings',
        icon: Icons.logout,
        onPressed: () => setState(() => Get.to(LogOut())),
        /*onPressed: () {
          Get.to(LogOut());
         print('image pick');
          setState(() {
            showDialog(context: context, builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Are you sure you want to logout ?",textAlign: TextAlign.center,),

                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      decoration: BoxDecoration(


                          border: Border.all(
                            color: Colors.white, // Set border color
                          ),   // Set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // Set rounded corner radius
                          boxShadow: [BoxShadow(blurRadius: 5,color: Colors.blue,)] // Make rounded corner of border
                      ),

                      child: MaterialButton(
                        onPressed: () async {

                          Get.back();


                        },
                        minWidth: 70,
                        height: 52.0,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            //fontSize: size.width* 0.03,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(

                          border: Border.all(
                            color: Colors.white, // Set border color
                          ),   // Set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // Set rounded corner radius
                          boxShadow: [BoxShadow(blurRadius: 5,color: Colors.blue,)] // Make rounded corner of border
                      ),
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
                  ],
                ),
              );
            });
          });
        },*/
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff80D0C1),
          body: CollapsibleSidebar(
            items: _items,
            avatarImg: _avatarImg,
           // title: snapshot.data['doctorName'],
            unselectedTextColor: Colors.black,
            unselectedIconColor: Colors.black,
            toggleTitle: 'Menu',
            // maxWidth: 20,
            minWidth: 60,iconSize: 20,
            body: landingWidget(page: _headline,),
            backgroundColor: Color(0xff80D0C1),
            selectedTextColor: Colors.limeAccent,
            textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            titleStyle: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            toggleTitleStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ));
      }

  //
  // Widget _body(Size size, BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       height: double.infinity,
  //       width: double.infinity,
  //       color: Colors.blueGrey[50],
  //       child: Center(
  //         child: Transform.rotate(
  //           angle: math.pi / 2,
  //           child: Transform.translate(
  //             offset: Offset(-size.height * 0.3, -size.width * 0.23),
  //             child: Text(
  //               _headline,
  //               style: Theme.of(context).textTheme.headline1,
  //               overflow: TextOverflow.visible,
  //               softWrap: false,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}


class landingWidget extends StatelessWidget {
  final int page;

  const landingWidget({Key key, this.page}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    switch(page)
    {
      case 0 : return ProfilePage();
      case 1 : return DoctorPanel();
      case 2 : return Appointments();
      case 3 : return PendingAppointment();
      case 4 : return CompleteAppointments();
      // case 3 : return OrderItems();
      // case 4 : return Categories();
      // case 5 : return StaffMembers();
      // case 6 : return BusinessProfile();
      // case 7 : return DineInTables();
      default : return ProfilePage();
    }
  }
}