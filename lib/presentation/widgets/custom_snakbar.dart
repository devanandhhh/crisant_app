
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomSnackBar(BuildContext context, String message, Color? bgColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style:GoogleFonts.aBeeZee(), // Text color
      ),
      backgroundColor: bgColor??Colors.grey, // Background color
      behavior: SnackBarBehavior.floating, // Makes it float above UI
      margin: EdgeInsets.all(16), // Adds margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      duration: Duration(seconds: 3), // Duration
    ),
  );
}
TextStyle abeezeeStyle({
  double fontSize = 16,       // default font size
  FontWeight fontWeight = FontWeight.normal, // default weight
  Color? color = Colors.black, // default color
  double letterSpacing = 0,   // default letter spacing
}) {
  return GoogleFonts.aBeeZee(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
  );
}