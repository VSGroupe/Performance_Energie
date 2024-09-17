import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';

// ignore: camel_case_types
class buttonIcon extends StatelessWidget {
  final VoidCallback tap;
  final String text;
  final Color color;
  final Color? backgroundColor;
  final IconData icon;
  final Color? iconcolor;
  final double? size;
  final double? width;
  final double? height;
  final FontWeight? weight;

  const buttonIcon({
    Key? key,
    required this.tap,
    required this.text,
    required this.color,
    this.backgroundColor,
    required this.icon,
    this.iconcolor,
    this.size,
    this.width,
    this.height,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      height: height ?? 30,
      child: ElevatedButton.icon(
        onPressed: tap,
        label: Text(
          text,
          style: TextStyle(
              fontSize: size ?? 16,
              fontWeight: weight ?? FontWeight.bold,
              color: color),
        ),
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(backgroundColor ?? Colors.white),
            elevation: const WidgetStatePropertyAll(3)),
        icon: Icon(
          icon,
          color: iconcolor ?? Colors.white,
        ),
      ),
    );
  }
}

class buttonType extends StatelessWidget {
  final VoidCallback? tap;
  final String text;
  final Color? color;
  final Color? textcolor1;
  final Color? textcolor2;
  final Color? hovercolor;
  final double? width;
  final double? height;
  final double? textsize;

  const buttonType({
    Key? key,
    required this.tap,
    required this.text,
    this.color,
    this.textcolor1,
    this.textcolor2,
    this.hovercolor,
    this.width,
    this.height,
    this.textsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: width ?? 300,
        height: height ?? 50,
        child: MaterialButton(
            onPressed: tap,
            elevation: 5.0,
            color: color ?? secondColor,
            hoverColor: hovercolor ?? primaryColor,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textcolor2 ?? texinvColor,
                  fontSize: textsize ?? 20,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}



