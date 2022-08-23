import 'package:flutter/material.dart';

class GlobalUtility {
  Color primary = const Color(0XFF09A963);
  Color secondary = const Color(0XFF102047);
  Color tertiary = const Color(0X9A00C774);
  Color alternate = const Color(0XFF173938);
  Color primaryBg = const Color(0XFFFFFFFF);
  Color secondaryBg = const Color(0XFFF7F6F6);
  Color popubBgFade = const Color(0X65000000);
  Color primaryText = const Color(0XFF141313);
  Color secondaryText = const Color(0XFFB6B6B6);
  Color transparente = const Color(0x00000000);

  TextStyle tituloPagina(BuildContext context) {
    return TextStyle(
        fontSize: 35,
        fontFamily: 'Bicyclette-Light',
        fontWeight: FontWeight.bold,
        color: primary);
  }

  TextStyle tituloPopUp(BuildContext context) {
    return TextStyle(
        fontSize: 30,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.bold,
        color: primaryBg);
  }

  TextStyle encabezadoTablasOff(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? TextStyle(
            fontSize: 20, fontFamily: 'Bicyclette-Bold', color: primaryBg)
        : TextStyle(
            fontSize: 20, fontFamily: 'Bicyclette-Bold', color: primary);
  }

  TextStyle encabezadoTablasOffAlt(BuildContext context) {
    return TextStyle(
        fontSize: 20, fontFamily: 'Bicyclette-Bold', color: primary);
  }

  TextStyle encabezadoTablasOn(BuildContext context) {
    return TextStyle(
        fontSize: 20, fontFamily: 'Bicyclette-Bold', color: primaryText);
  }

  TextStyle contenidoTablas(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? TextStyle(
            fontSize: 13,
            fontFamily: 'Gotham-Light',
            fontWeight: FontWeight.w300,
            color: primaryText)
        : TextStyle(
            fontSize: 13,
            fontFamily: 'Gotham-Light',
            fontWeight: FontWeight.w300,
            color: primaryBg);
  }

  TextStyle label(BuildContext context) {
    return TextStyle(fontSize: 13, fontFamily: 'Gotham-Light', color: primary);
  }

  TextStyle textoIgual(BuildContext context) {
    return TextStyle(
        fontSize: 13,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w600,
        color: primaryText);
  }

  TextStyle textoA(BuildContext context) {
    return TextStyle(
        fontSize: 13, fontFamily: 'Gotham-Light', color: primaryText);
  }

  TextStyle hinttxt(BuildContext context) {
    return TextStyle(fontSize: 13, fontFamily: 'Gotham-Light', color: primary);
  }

  TextStyle textoIgual2(BuildContext context) {
    return TextStyle(fontSize: 15, fontFamily: 'Gotham-Light', color: primary);
  }

  TextStyle textoA2(BuildContext context) {
    return TextStyle(
        fontSize: 13, fontFamily: 'Gotham-Bold', color: primaryText);
  }

  TextStyle textoError(BuildContext context) {
    return TextStyle(
        fontSize: 13, fontFamily: 'Gotham-Light', color: Colors.red);
  }

  TextStyle textoError2(BuildContext context) {
    return TextStyle(
        fontSize: 13, fontFamily: 'Gotham-Bold', color: Colors.red);
  }
}
