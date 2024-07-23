import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextWidget extends StatefulWidget {
  final String text;
  final double fontsize;
  final Color fontcolor;
  final FontWeight? fontweight;
  const BuildTextWidget(
      {super.key,
      required this.text,
      required this.fontsize,
      required this.fontcolor,
      this.fontweight});

  @override
  State<BuildTextWidget> createState() => _BuildTextWidgetState();
}

class _BuildTextWidgetState extends State<BuildTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        style: GoogleFonts.robotoSlab(
          fontWeight: widget.fontweight,
          fontSize: widget.fontsize,
          color: widget.fontcolor,
        ));
  }
}
