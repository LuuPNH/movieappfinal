import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

class ButtonForm extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? colorButton;
  final String? titleButton;
  final Function()? function;
  final Icon? icon;

  const ButtonForm({Key? key, this.colorButton, this.titleButton, this.function, this.height, this.width, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width ?? 50.0,
      height: height ?? 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: colorButton ?? Colors.white,
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(titleButton ?? "No Name" , style: TextStyle( fontWeight: FontWeight.bold),),
        ),

        onPressed: function ?? null,
      ),
    );
  }
}
