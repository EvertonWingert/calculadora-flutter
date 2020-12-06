import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  Button(
      {Key key,
      this.color,
      this.textColor,
      this.buttonText,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style:GoogleFonts.montserrat(textStyle: TextStyle(
                    color: textColor,
                    fontSize: 20,)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
