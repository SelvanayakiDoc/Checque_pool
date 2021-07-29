import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/new_appointments/new_appointment_controller.dart';
import 'package:flutter_app_checkque_pool/appointments/new_appointments/new_appointments.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DatetimePickerWidget extends StatefulWidget {
  @override
  _DatetimePickerWidgetState createState() => _DatetimePickerWidgetState();
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  DateTime dateTime;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future userLogin() async{

    // Showing CircularProgressIndicator.


    // Getting value from Controller
    String name = NewAppointmentController.name;
    dynamic age = NewAppointmentController.age;
    dynamic city = NewAppointmentController.city;
    dynamic state = NewAppointmentController.state;
    dynamic ph = NewAppointmentController.ph;
    dynamic problem = NewAppointmentController.suffer;
    dynamic doc = NewAppointmentController.docid;
    dynamic hos = NewAppointmentController.hosid;
    dynamic date = DateFormat('yyyy-MM-dd').format(dateTime);
    dynamic time = DateFormat('HH:mm').format(dateTime);
    print(' Name is ${NewAppointmentController.name}');
    print(' Age is ${NewAppointmentController.age}');
    print(' City is ${NewAppointmentController.city}');
    print(' State is ${NewAppointmentController.state}');
    print(' phone num is ${NewAppointmentController.ph}');
    print(' problem num is ${NewAppointmentController.suffer}');
    print(' Docter id num is ${NewAppointmentController.docid}');
    print(' Hospital Id num is ${NewAppointmentController.hosid}');

    print('DateFormat of dateTime is ${date}');
    print('DateFormat of dateTime is ${time}');




    // SERVER LOGIN API URL
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/apadd';

    // Store all data with Param Name.

    var data = {
      "full_name": NewAppointmentController.name,
      "age" : NewAppointmentController.age,
      "city": NewAppointmentController.city,
      "state": NewAppointmentController.state,
      "mobile": NewAppointmentController.ph,
      "problem": NewAppointmentController.suffer,
      "doctor_id": NewAppointmentController.docid,
      "hospital_id": NewAppointmentController.hosid,
      "date":date,
      "Time":time,
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if(response.statusCode==200)
    {
      Get.snackbar('Done','Your Appointment has been added Successfully',backgroundColor: Colors.green ,colorText: Colors.white);
      Get.to(Appointments());
      Get.snackbar('Done','Your Appointment has been added Successfully',backgroundColor: Colors.green ,colorText: Colors.white);


    }
    else{
      Get.snackbar('Warning', 'Please Enter Valid details',backgroundColor: Colors.red ,colorText: Colors.white);
      print(response.statusCode);
    }

    // Getting Server response into variable.


    // If the Response Message is Matched.

    // If Email or Password did not Matched.
    // Hiding the CircularProgressIndicator.


    // Showing Alert Dialog with Response JSON Message.


  }


  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('yyyy/MM/dd HH:mm').format(dateTime);

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NewAppointmentController.age;

    print('username'+NewAppointmentController.age);

  }

  @override
  Widget build(BuildContext context) => Scaffold(

    body: Center(
      child:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                3.0, 2.0), // 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xff80D0C9),
              Color(0xff0093E9)
            ], // red to yellow
            tileMode: TileMode
                .repeated, // repeats the gradient over the canvas
          ),
        ),

        child: Column(

          children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                      //Get.back();
                    }),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height:MediaQuery.of(context).size.height * 0.2 ,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhotoHero(
                    photo: "assets/cp-logo.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),

              ],
            ),
            ButtonHeaderWidget(
              title: '',
              text: getText(),
              onClicked: () => pickDateTime(),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              child: Text('Allocate Appointments',textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                ),

              ),onPressed: (){
                userLogin();
                //Get.snackbar('Done','Your Appointment has been added Successfully',backgroundColor: Colors.green ,colorText: Colors.white);

            },

            ),
          ],
        ),]
      ),
    ),)
  );

  Future pickDateTime() async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,

      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;
    //print(DateFormat('yyyy/MM/dd').format(dateTime));

    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;
  //  print(DateFormat('HH:mm').format(dateTime));

    return newTime;
  }
}

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key key,
    @required this.title,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
    title: title,
    child: ButtonWidget(
      text: text,
      onClicked: onClicked,
    ),
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.square(50),
      //alignment: Alignment(20, 40),
      primary: Colors.white,
    ),
    child: FittedBox(
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ),
    onPressed: onClicked,
  );
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      child,
    ],
  );
}