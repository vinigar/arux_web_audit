import 'package:arux/pages/widgets/toasts/success_toast.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:arux/helpers/constants.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/services/api_error_handler.dart';
import 'package:arux/theme/theme.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/bg1arux.png',
              ).image,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(100, 50, 0, 0),
                  child: Image.asset(
                    'assets/images/1e2wnRecurso_2aruxlogoletraswhite.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                          child: Text(
                            'Reestablecer \ncontraseña',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Bicyclette',
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: false,
                                ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                          child: Text(
                            'Ingresa el correo registrado a tu cuenta.\n\nDe esta forma sabremos que esta cuenta te pertenece',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFF09A963),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Form(
                              key: formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    30, 0, 30, 0),
                                child: TextFormField(
                                  controller: emailAddressController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'El correo es requerido';
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return 'Por favor ingresa un correo válido';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintStyle: AppTheme.of(context).bodyText2,
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 15, 0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  final res = await supabase.auth.api
                                      .resetPasswordForEmail(
                                    emailAddressController.text,
                                    options: AuthOptions(
                                      redirectTo: redirectUrl,
                                    ),
                                  );

                                  if (res.error != null) {
                                    final msg =
                                        ApiErrorHandler.translateErrorMsg(
                                            res.error!.message);
                                    Fluttertoast.showToast(
                                        msg: msg,
                                        toastLength: Toast.LENGTH_SHORT,
                                        webBgColor: "#e74c3c",
                                        textColor: Colors.black,
                                        timeInSecForIosWeb: 5,
                                        webPosition: 'center');
                                    return;
                                  }

                                  if (!mounted) return;
                                  fToast.showToast(
                                    child: const SuccessToast(
                                      message: 'Correo enviado',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 2),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF09A963),
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: Text(
                  'Copyright © 2022, Arux. Website by Grupo Mariposa',
                  style: AppTheme.of(context).bodyText1.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
