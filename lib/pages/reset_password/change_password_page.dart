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
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/bgaruxlogin_Mesa_de_trabajo_1.png',
                  ).image,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF161616), Color(0xFF37A26B)],
                  stops: [0, 1],
                  begin: AlignmentDirectional(1, 0),
                  end: AlignmentDirectional(-1, 0),
                ),
              ),
            ),
            Positioned(
              left: 150,
              top: 200,
              child: Material(
                color: Colors.transparent,
                elevation: 80,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: 500,
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF37A26B), Color(0xFF116538)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0.34, -1),
                      end: AlignmentDirectional(-0.34, 1),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SingleChildScrollView(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    4, 40, 4, 4),
                                child: Text(
                                  'Cambiar contraseña',
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 0),
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
                                    labelText: 'Nueva contraseña *',
                                    labelStyle:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                    hintText: 'Ingresa contraseña...',
                                    hintStyle:
                                        AppTheme.of(context).bodyText2.override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFFA5A5A5),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFF414040),
                                  ),
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
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
                                    labelText: 'Confirmar contraseña *',
                                    labelStyle:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                    hintText: 'Confirma tu contraseña...',
                                    hintStyle:
                                        AppTheme.of(context).bodyText2.override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFFA5A5A5),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFF414040),
                                  ),
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 24, 0, 0),
                                child: CustomButton(
                                  onPressed: () async {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    print(widget.token);
                                    final res =
                                        await supabase.auth.api.updateUser(
                                      widget.token,
                                      UserAttributes(
                                        password:
                                            nuevaContrasenaController.text,
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
                                    width: 190,
                                    height: 50,
                                    color: const Color(0xFF39D24A),
                                    textStyle:
                                        AppTheme.of(context).subtitle2.override(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 150,
              top: 50,
              child: Image(
                image: AssetImage(
                    'assets/images/1e2wnRecurso_2aruxlogoletraswhite.png'),
                height: 110,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
