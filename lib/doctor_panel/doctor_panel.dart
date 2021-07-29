import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/doctor_panel/panelClinic_model.dart';
import 'package:flutter_app_checkque_pool/doctor_panel/panelhospital_model.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class DoctorPanel extends StatefulWidget {
  @override
  _DoctorPanelState createState() => _DoctorPanelState();
}

class _DoctorPanelState extends State<DoctorPanel> {

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController date1Controller = TextEditingController();
 // List data = [];
  // ignore: deprecated_member_use
  List data = List();
  // ignore: deprecated_member_use
  List data1 = List();
  Future<AllHospital> _hosModel;
  Future<AllClinic> _clinicModel;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String _chosenValue1;
  String _chosenValue;
  var _chosenValue2;
  var _chosenValue3;
  var _chosenValue4;

  get index => null;
  Future<AllHospital> hospital() async {
    var hosModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/allhospital';

    var response = await http.get(Uri.parse(url),

    );
    if (response.statusCode == 200) {
      print(response.body);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      setState(() {
        data = jsonMap['result_data'];
      });
      hosModel = AllHospital.fromJson(jsonMap);
      return hosModel;
    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }
  }
  Future<AllClinic> clinic() async {
    var clinicModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/allclinic';

    var response = await http.get(Uri.parse(url),

    );
    if (response.statusCode == 200) {
      print(response.body);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      setState(() {
        data1 = jsonMap['result_data'];
      });
      clinicModel = AllClinic.fromJson(jsonMap);
      return clinicModel;
    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }
  }
  Future available() async {
    print("username is ${loginController.userName.toString()}");
    print("hospital id is ${_chosenValue1}");
    print("date id is ${nameController.text}");
    print("start time id is ${dateController.text}");
    print("end time id is ${date1Controller.text}");
    var clinicModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/docavail';
    var data = {
      'doctor_id': loginController.userName.toString(),

      "hospital_id":_chosenValue1,
      "date":nameController.text,
      "start_time":dateController.text,
      "end_time":date1Controller.text,
    };

    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if (response.statusCode == 200) {
      print(response.body);
      Get.snackbar('Done','Your Avalability added Successfully',backgroundColor: Colors.red ,colorText: Colors.white);
      return "success";
    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _hosModel = hospital();
    _clinicModel = clinic();
    super.initState();}
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
                  child:Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(3.0,
                            2.0), // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Color(0xff80D0C9),
                          Color(0xff0093E9)
                        ], // red to yellow
                        tileMode: TileMode
                            .repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 40,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PhotoHero(
                              photo:  "assets/cp-logo.png",
                              width: size.width * 0.4,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          Column(
                            children: [
                              Text("Doctor Panel",
                                style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text("Hospital/clinic",
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          /*Container(
            width: 250.0,
            height: 40.0,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 58.0,top:0 ),
              child: Row(
                children: [
                  Text("Hospital/Clinic Name", style: TextStyle(color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(left:28.0),
                    child: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  )
                ],
              ),
            ),


          ),
          Container(
            width: 250.0,
            height: 100.0,
            color: Colors.blueGrey[800],
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("Name 1", style: TextStyle(color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Text("Name 1", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),*/
                          Padding(
                            padding: const EdgeInsets.all( 10),
                            child: Form(

                              // key: createController.hospitalKey,
                              child: Container(
                                // color: Colors.black,
                                padding: EdgeInsets.only(
                                    right: 22),
                                decoration: new BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: new BorderRadius.all(new Radius.circular(16.0))),
                                child:Padding(
                                  padding: const EdgeInsets.only( left:12, right: 4),

                                  child: DropdownButtonHideUnderline(

                                    child: DropdownButton<String>(
                                      dropdownColor:Color(0xff1a1a1a
                                      ),
                                      iconEnabledColor: Colors.white,
                                      //icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,

                                      value: _chosenValue1,
                                      elevation: 5,
                                      style: TextStyle(color: Colors.white),


                                      items: data.map((item){
                                        return DropdownMenuItem(
                                          child: Text(item['hid']),
                                          value: item['hid'].toString()

                                        );
                                      }).toList(),
                                      hint: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Select the Hospital id",
                                          style: TextStyle(
                                            fontSize: size.width* 0.04,
                                            color:Colors.white,),
                                        ),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue1= value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /*Padding(
                            padding: const EdgeInsets.all( 10),
                            child: Form(

                              // key: createController.hospitalKey,
                              child: Container(
                                // color: Colors.black,
                                padding: EdgeInsets.only(
                                    right: 22),
                                decoration: new BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: new BorderRadius.all(new Radius.circular(16.0))),
                                child:Padding(
                                  padding: const EdgeInsets.only( left:12, right: 4),

                                  child: DropdownButtonHideUnderline(

                                    child: DropdownButton<String>(
                                      dropdownColor:Color(0xff1a1a1a
                                      ),
                                      iconEnabledColor: Colors.white,
                                      //icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,

                                      value: _chosenValue,
                                      elevation: 5,
                                      style: TextStyle(color: Colors.white),


                                      items: data1.map((item){
                                        return DropdownMenuItem(
                                            child: Text(item['hid']),
                                            value: item['id'].toString()

                                        );
                                      }).toList(),
                                      hint: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Select the Hospital",
                                          style: TextStyle(
                                            fontSize: size.width* 0.04,
                                            color:Colors.white,),
                                        ),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue= value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 10),
                            child: Text("Available Date", style: TextStyle(fontSize: size.width * 0.05,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,),),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all( 10),
                            child: Form(

                              // key: createController.hospitalKey,
                              child: Container(
                                // color: Colors.black,
                                padding: EdgeInsets.only(
                                    right: 22),
                                decoration: new BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: new BorderRadius.all(new Radius.circular(16.0))),
                                child:Padding(
                                  padding: const EdgeInsets.only( left:12, right: 4),

                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),


                                    textCapitalization: TextCapitalization.words,
                                    keyboardType: TextInputType.text,
                                    controller: nameController,

                                    onChanged: (value){
                                     _chosenValue2=value as TextEditingController;

                                    },
                                    autofillHints: [AutofillHints.givenName],
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText:'Date should be YY-MM-DD' ,
                                        hintStyle: TextStyle(
                                          color: Colors.white60,


                                        ),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        focusColor: Colors.white),
                                  ),/*DropdownButtonHideUnderline(

                                    child: DropdownButton<String>(
                                      dropdownColor:Color(0xff1a1a1a
                                      ),
                                      iconEnabledColor: Colors.white,
                                      //icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,

                                      value: _chosenValue2,
                                      elevation: 5,
                                      style: TextStyle(color: Colors.white),

                                      items: <String>[
                                        '2021-07-14',
                                        '2021-07-15',
                                        '2021-07-16',
                                        '2021-07-17',
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      hint: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Select the Date",
                                          style: TextStyle(
                                            fontSize: size.width* 0.04,
                                            color:Colors.white,),
                                        ),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue2 = value;
                                        });
                                      },
                                    ),
                                  ),*/
                                ),
                              ),
                            ),
                          ),
                          /* Container(
            width: 250.0,
            height: 40.0,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:105.0),
                  child: Text("11.5.2021", style: TextStyle(color: Colors.white),),
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down,color: Colors.white,)
              ],
            ),


          ),
          Container(
            width: 250.0,
            height: 140.0,
            color: Colors.blueGrey[800],
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("13.5.2021", style: TextStyle(color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Text("14.5.2021", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),*/


                          Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 10),
                            child: Text("Available Time", style: TextStyle(fontSize: size.width * 0.05,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,),),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.all( 10),
                            child: Form(

                              // key: createController.hospitalKey,
                              child: Container(
                                // color: Colors.black,
                                padding: EdgeInsets.only(
                                    right: 22),
                                decoration: new BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: new BorderRadius.all(new Radius.circular(16.0))),
                                child:Padding(
                                  padding: const EdgeInsets.only(left:12,  right: 4),

                                  child:TextFormField(
                                    style: TextStyle(color: Colors.white),


                                    textCapitalization: TextCapitalization.words,
                                    keyboardType: TextInputType.text,
                                    controller: dateController,

                                    onChanged: (value){
                                      _chosenValue4=value as TextEditingController;

                                    },
                                    autofillHints: [AutofillHints.givenName],
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText:'Starting Time HH:MM' ,
                                        hintStyle: TextStyle(
                                          color: Colors.white60,

                                        ),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        focusColor: Colors.white),
                                  )
                                  /* DropdownButtonHideUnderline(

                                    child: DropdownButton<String>(
                                      dropdownColor:Color(0xff1a1a1a
                                      ),
                                      iconEnabledColor: Colors.white,
                                      //icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,

                                      value: _chosenValue4,
                                      elevation: 5,
                                      style: TextStyle(color: Colors.white),

                                      items: <String>[
                                        '10 AM ',
                                        '12 PM',
                                        '3 PM ',

                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      hint: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Select the Starting time",
                                          style: TextStyle(
                                            fontSize: size.width* 0.04,
                                            color:Colors.white,),
                                        ),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue4 = value;
                                        });
                                      },
                                    ),
                                  ),*/
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all( 10),
                            child: Form(

                              // key: createController.hospitalKey,
                              child: Container(
                                // color: Colors.black,
                                padding: EdgeInsets.only(
                                    right: 22),
                                decoration: new BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: new BorderRadius.all(new Radius.circular(16.0))),
                                child:Padding(
                                  padding: const EdgeInsets.only(left:12,  right: 4),

                                  child: DropdownButtonHideUnderline(

                                    child:
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      textCapitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.text,
                                      controller: date1Controller,

                                      onChanged: (value){
                                        _chosenValue3=value as TextEditingController;

                                      },
                                      autofillHints: [AutofillHints.givenName],
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText:'Ending should be HH:MM' ,
                                          hintStyle: TextStyle(
                                            color: Colors.white60,

                                          ),
                                          hoverColor: Colors.white,
                                          filled: true,
                                          focusColor: Colors.white),
                                    )/* DropdownButton<String>(
                                      dropdownColor:Color(0xff1a1a1a
                                      ),
                                      iconEnabledColor: Colors.white,
                                      //icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,

                                      value: _chosenValue3,
                                      elevation: 5,
                                      style: TextStyle(color: Colors.white),

                                      items: <String>[
                                        '2 PM',
                                        '4 PM',
                                        '5 PM',

                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      hint: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Select the Ending time",
                                          style: TextStyle(
                                            fontSize: size.width* 0.04,
                                            color:Colors.white,),
                                        ),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue3 = value;
                                        });
                                      },
                                    ),*/
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Material(
                              elevation: 5.0,
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30.0),
                              child: MaterialButton(
                                onPressed: () async {
                                  available();
                                  //Get.to(Appointments());
                                 //
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
                                height: 52.0,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    //fontSize: size.width* 0.03,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /* Container(
            width: 250.0,
            height: 40.0,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:105.0),
                  child: Text("11.5.2021", style: TextStyle(color: Colors.white),),
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down,color: Colors.white,)
              ],
            ),


          ),
          Container(
            width: 250.0,
            height: 120.0,
            color: Colors.blueGrey[800],
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("13.5.2021", style: TextStyle(color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Text("14.5.2021", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),*/
                          // alignment: Alignment.topLeft, // where to position the child



                        ]),
                  )),


         );
  }
}
// ignore: missing_return

