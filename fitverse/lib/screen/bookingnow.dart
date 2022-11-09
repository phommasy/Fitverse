import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitverse/model/reservation.dart';
import 'package:fitverse/screen/bookmarkpage.dart';
import 'package:fitverse/screen/homemenu.dart';
import 'package:fitverse/tabandbloc/reservationbloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FormBookingNow extends StatefulWidget {
  final String articleID;
  final String titleID;
  final String imageID;
  final String detailID;
  final String categoryID;
  const FormBookingNow(
      {Key key,
      this.articleID,
      this.titleID,
      this.imageID,
      this.detailID,
      this.categoryID})
      : super(key: key);

  @override
  State<FormBookingNow> createState() => _FormBookingNowState();
}

class _FormBookingNowState extends State<FormBookingNow> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  final auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  Reservation myReservation = Reservation();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  CollectionReference _myreservationCollection =
      FirebaseFirestore.instance.collection("reservation_tb");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error!"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Reservation Form"),
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reservation Date",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    "Please enter your reservation date!"),
                          ]),
                          controller: dateinput,
                          decoration: InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "Enter Date"),
                          readOnly: true,
                          onTap: () async {
                            DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy/MM/dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          onSaved: (String rsdate) {
                            myReservation.rsdate = rsdate;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Reservation Time",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    "Please enter your reservation time!"),
                          ]),
                          controller:
                              timeinput, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(Icons.timer), //icon of text field
                              labelText: "Enter Time" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            TimeOfDay pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context, //context of current state
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              // DateTime parsedTime = DateFormat.jm()
                              //     .parse(pickedTime.format(context).toString());
                              // //converting to DateTime so that we can further format on different pattern.
                              // print(
                              //     parsedTime); //output 1970-01-01 22:53:00.000
                              // String formattedTime =
                              //     DateFormat('HH:mm:ss').format(parsedTime);
                              // print(formattedTime); //output 14:59:00
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                timeinput.text = pickedTime.format(
                                    context); //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                          onSaved: (String starttiem) {
                            myReservation.starttiem = starttiem;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Reservation Remark",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter your remark here!"),
                          onSaved: (String rsdetail) {
                            myReservation.rsdetail = rsdetail;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              "Booking",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              if (formkey.currentState.validate()) {
                                formkey.currentState.save();
                                try {
                                  await _myreservationCollection.add({
                                    "cid": widget.articleID,
                                    "rsdate": myReservation.rsdate,
                                    "rsdetail": myReservation.rsdetail,
                                    "email": auth.currentUser.email,
                                    "uid": auth.currentUser.uid,
                                    "title": widget.titleID,
                                    "image": widget.imageID,
                                    "detail": widget.detailID,
                                    "category": widget.categoryID,
                                    "starttiem": myReservation.starttiem,
                                    "timestamp":
                                        DateTime.now().millisecondsSinceEpoch,
                                  });
                                  formkey.currentState.reset();
                                  Fluttertoast.showToast(
                                      msg: "Reservation successful!",
                                      gravity: ToastGravity.CENTER);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => BookmarkScreen()),
                                  // ).then((value) => setState(() {}));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomeScreen();
                                  }));
                                } on FirebaseAuthException catch (e) {
                                  String messagealerts;

                                  messagealerts = e.message;

                                  // print(e.message);
                                  //print(e.code);
                                  Fluttertoast.showToast(
                                      msg: messagealerts,
                                      gravity: ToastGravity.CENTER);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
