import 'package:flutter/material.dart';

class GlobalUtility {
  Color primary = const Color(0XFF04C774);
  Color secondary = const Color(0XFF102047);
  Color tertiary = const Color(0X9A00C774);
  Color alternate = const Color(0XFF173938);
  Color primaryBg = const Color(0XFFFFFFFF);
  Color secondaryBg = const Color(0XFFF7F6F6);
  Color primaryText = const Color(0XFF141313);
  Color secondaryText = const Color(0XFFB6B6B6);
  Color transparente = const Color(0x00000000);

  TextStyle tituloPagina(BuildContext context) {
    return TextStyle(
        fontSize: 60,
        fontFamily: 'Bicyclette',
        fontWeight: FontWeight.bold,
        color: primary);
  }

  TextStyle encabezadoTablasOff(BuildContext context) {
    return TextStyle(
        fontSize: 25,
        fontFamily: 'Bicyclette-Bold',
        color: primaryBg);
  }

  TextStyle encabezadoTablasOffAlt(BuildContext context) {
    return TextStyle(
        fontSize: 25,
        fontFamily: 'Bicyclette-Bold',
        color: primary);
  }

  TextStyle encabezadoTablasOn(BuildContext context) {
    return TextStyle(
        fontSize: 25, fontFamily: 'Bicyclette-Bold', color: primaryText);
  }

  TextStyle contenidoTablas(BuildContext context) {
    return TextStyle(
        fontSize: 18,
        fontFamily: 'Gotham-Light',
        fontWeight: FontWeight.w300,
        color: primaryText);
  }

  TextStyle textoIgual(BuildContext context) {
    return TextStyle(
        fontSize: 18,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w600,
        color: primaryText);
  }

  TextStyle textoA(BuildContext context) {
    return TextStyle(
        fontSize: 18, fontFamily: 'Gotham-Light', color: primaryText);
  }

  TextStyle hinttxt(BuildContext context) {
    return TextStyle(
        fontSize: 18, fontFamily: 'Gotham-Light', color: secondaryText);
  }


}
