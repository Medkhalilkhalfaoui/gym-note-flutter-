import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inputdeco.dart';
import 'package:intl/intl.dart';
import 'listexpanded.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
   String valuec;

  List listitemes = ["     musculation", "     taekwondo","     kickboxing"];
  DateTime _date = DateTime.now();

  Future<Null> _selectedDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
      });
    }
  }

  void set() {
    setState(() {
      _selectedDate(context);
    });
  }
  var myController = TextEditingController();
  var myController1 = TextEditingController();
  var myController2 = TextEditingController();
   File _image ;
  final imagePicker = ImagePicker();
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera) ;
    setState(() {
      _image = File(image.path);
    });
  }
  Image iconImg (){
    return _image== null? Image.asset('assets/mon.jpg',fit: BoxFit.cover, height: 140,width: 140,): Image.file(_image, fit: BoxFit.cover, height: 140,width: 140,);
  }



  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: iconImg(),
                  ),
                ),

                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          color: Colors.grey,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.photo_camera,color: Colors.red,),
                          onPressed: getImage,
                        )
                    )),
              ],
            ),

            SizedBox(
              height: 15,
            ),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: buildInputDecoration(Icons.person, "nom et prénom", null),
                controller: myController,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: Container(
                padding:
                EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(25.0)),
                child: DropdownButton(
                  hint: Text("       Filières", style: TextStyle(fontSize: 16,color: Colors.black),),
                  dropdownColor: Colors.grey,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  value: valuec,
                  onChanged: (newValue) {
                    setState(() {
                      valuec = newValue;
                    });
                  },
                  items: listitemes.map((valueitem) {
                    return DropdownMenuItem(
                      value: valueitem,
                      child: Text(valueitem,style: TextStyle(fontSize: 16),),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: buildInputDecoration(Icons.phone, "Téléphone", null),
                controller: myController1,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter phone no ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                 onTap: set,
                  readOnly: true,
                  decoration: buildInputDecoration1(
                      null,DateFormat.yMMMd().format(_date).toString(), Icons.date_range, set)),
            ),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: buildInputDecoration(
                    Icons.attach_money, "prix d'abonnement ", 'DT'),
                controller: myController2,
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                color: Colors.red,
                onPressed: () => setState((){
                  data.add(
                      Item(img: iconImg(), expandedValue: valuec, headerValue: myController.text, dt: _date,phone: int.parse(myController1.text), prix: int.parse(myController2.text),)
                  );
                  /*Future<void> addUser() {
                    return users
                        .doc(myController.text)
                        .set({
                      'dt': _date,
                      'fil': valuec,
                      'name': myController.text,
                      'phone': int.parse(myController1.text),
                      'prix':  int.parse(myController2.text)
                    })
                        .then((value) => print("User Added"))
                        .catchError((error) => print("Failed to add user: $error"));
                  }*/

                  myController1.clear();
                  myController.clear();
                  myController2.clear();
                  valuec= null;
                  _date = DateTime.now();
                  _image = null;

                }),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.black, width: 2)),
                textColor: Colors.white,
                child: Text("Register"),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

