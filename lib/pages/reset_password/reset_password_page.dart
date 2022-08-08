import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/widgets/custom_button.dart';
import 'package:arux/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailAddressController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                        child: Text(
                          'Ingresa tu dirección de correo electrónico.\nTe enviaremos un enlace para reestablecer tu contraseña.',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context).bodyText2.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                        child: Container(
                          width: 400,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).secondaryBackground,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x4D101213),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: emailAddressController,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El correo es requerido';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Por favor ingresa un correo válido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              labelStyle: AppTheme.of(context).bodyText2,
                              hintText: 'Ingresa tu correo electrónico...',
                              hintStyle:
                                  AppTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor:
                                  AppTheme.of(context).secondaryBackground,
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 20, 24),
                            ),
                            style: AppTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: CustomButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            final res =
                                await supabase.auth.api.resetPasswordForEmail(
                              emailAddressController.text,
                              options: AuthOptions(
                                redirectTo:
                                    'http://localhost:50120/#/change-password',
                              ),
                            );

                            //TODO: handle errors
                            if (res.error != null) {
                              print('Error al realizar la petición');
                              print(res.error!.message);
                              return;
                            }

                            if (!mounted) return;
                            //TODO: change page
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const PasswordEmailSentScreen(),
                            //   ),
                            // );
                          },
                          text: 'Enviar enlace',
                          options: ButtonOptions(
                            width: 270,
                            height: 50,
                            color: const Color(0xFF2CC3F4),
                            textStyle: AppTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color:
                                      AppTheme.of(context).secondaryBackground,
                                ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
