import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(IconData icons,String hinttext, String str ) {
  return InputDecoration(
    labelText: hinttext,
    labelStyle: TextStyle(fontSize: 16, color: Colors.black),

    hintText: hinttext,
    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
    prefixIcon: Icon(icons),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
          color: Colors.red,
          width: 1.5
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
    ),
    enabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
    ),
    suffixText: str,

  );
}
InputDecoration buildInputDecoration1(IconData icons,String hinttext, IconData ic,Function x) {
  return InputDecoration(
      labelText: "expiré le :  " + hinttext,
      labelStyle: TextStyle(fontSize: 16, color: Colors.black),
      hintText: hinttext,
      hintStyle: TextStyle(fontSize: 16, color: Colors.black),
      prefixIcon: Icon(icons),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
            color: Colors.red,
            width: 1.5
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      enabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      suffixIcon: IconButton(
          icon: Icon(ic),
          onPressed: x
      ),

  );
}