import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/widgets/custom_button.dart';
import 'package:arux/theme/theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String token;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController nuevaContrasenaController = TextEditingController();
  TextEditingController confNuevaContrasenaController = TextEditingController();
  bool nuevaContrasenaVisibility = false;
  bool confNuevaContrasenaVisibility = false;

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
                          'Cambiar contraseña',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context).bodyText2.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: nuevaContrasenaController,
                            obscuringCharacter: '*',
                            obscureText: !nuevaContrasenaVisibility,
                            validator: (value) {
                              // final RegExp regex = RegExp(
                              //     r"^(?=.*[A-Z])(?=.*\d)(?=.*\d)[A-Za-z\d!#\$%&/\(\)=?¡¿+\*\.-_:,;]{8,50}$");
                              if (value == null || value.isEmpty) {
                                return 'La contraseña es requerida';
                              }
                              // else if (!regex.hasMatch(value)) {
                              //   return 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula y dos números.\nLos caracteres especiales válidos son: !#\$%&/()=?¡¿+*.-_:,; y no se permite el uso de\nespacios, tildes o acentos.';
                              // }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nueva Contraseña',
                              labelStyle:
                                  AppTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresa contraseña...',
                              hintStyle:
                                  AppTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF006AFF),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF006AFF),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: const Color(0x52FFFFFF),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => nuevaContrasenaVisibility =
                                      !nuevaContrasenaVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  nuevaContrasenaVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF006AFF),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: TextFormField(
                            controller: confNuevaContrasenaController,
                            obscureText: !confNuevaContrasenaVisibility,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'La contraseña de confirmación es requerida';
                              } else if (value !=
                                  nuevaContrasenaController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirmar Contraseña',
                              labelStyle:
                                  AppTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Confirma la contraseña...',
                              hintStyle:
                                  AppTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF006AFF),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF006AFF),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: const Color(0x52FFFFFF),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => confNuevaContrasenaVisibility =
                                      !confNuevaContrasenaVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  confNuevaContrasenaVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF006AFF),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
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
                            print(widget.token);
                            final res = await supabase.auth.api.updateUser(
                              widget.token,
                              UserAttributes(
                                password: nuevaContrasenaController.text,
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
                          text: 'Cambiar contraseña',
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
