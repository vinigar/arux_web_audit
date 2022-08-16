import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/pages.dart';
import 'package:arux/pages/widgets/custom_button.dart';
import 'package:arux/services/api_error_handler.dart';
import 'package:arux/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: //BOTON
            Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
          child: CustomButton(
            onPressed: () async {
              final res = await supabase.auth.signOut();

              if (res.error != null) {
                final msg =
                    ApiErrorHandler.translateErrorMsg(res.error!.message);
                Fluttertoast.showToast(
                  msg: msg,
                  toastLength: Toast.LENGTH_SHORT,
                  webBgColor: "#e74c3c",
                  textColor: Colors.black,
                  timeInSecForIosWeb: 5,
                  webPosition: 'center',
                );
                return;
              }

              if (!mounted) return;
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            text: 'Cerrar sesión',
            options: ButtonOptions(
              width: 170,
              height: 50,
              color: const Color(0xFF39D24A),
              textStyle: AppTheme.of(context).subtitle2.override(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
              elevation: 0,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
