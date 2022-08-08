import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/pages.dart';
import 'package:arux/pages/widgets/custom_button.dart';
import 'package:arux/router/router.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:arux/pages/widgets/toggle_icon.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisibility = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
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
            const Positioned(
              bottom: 0,
              right: 290,
              child: Image(
                image: AssetImage('assets/images/My_project-1.png'),
                height: 690,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Positioned(
              left: 150,
              top: 200,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 80,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 500,
                      height: 630,
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
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      40, 40, 0, 0),
                                  child: Text(
                                    '¡Hola!',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 30,
                                            ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      40, 0, 0, 0),
                                  child: Text(
                                    'Inicia sesión,',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 40,
                                            ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    40, 10, 40, 0),
                                child: TextFormField(
                                  controller: userState.emailController,
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
                                    labelText: 'Usuario*',
                                    labelStyle:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                    hintText: 'Ingresa usuario...',
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
                                    40, 20, 40, 0),
                                child: TextFormField(
                                  controller: userState.passwordController,
                                  obscureText: !passwordVisibility,
                                  obscuringCharacter: '*',
                                  validator: (value) {
                                    //TODO: revisar validacion
                                    // final RegExp regex = RegExp(
                                    //     r"^(?=.*[A-Z])(?=.*\d)(?=.*\d)[A-Za-z\d!#\$%&/\(\)=?¡¿+\*\.-_:,;]{8,50}$");
                                    if (value == null || value.isEmpty) {
                                      return 'La contraseña es requerida';
                                    }
                                    //  else if (!regex.hasMatch(value)) {
                                    //   return 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula y dos números.\nLos caracteres especiales válidos son: !#\$%&/()=?¡¿+*.-_:,; y no se permite el uso de\nespacios, tildes o acentos.';
                                    // }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña*',
                                    labelStyle:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                    hintText: 'Contraseña...',
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
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility =
                                            !passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: const Color(0xFFA5A5A5),
                                        size: 22,
                                      ),
                                    ),
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

                              //BOTON
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 15, 0, 0),
                                child: CustomButton(
                                  onPressed: () async {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    //Login

                                    final res = await supabase.auth.signIn(
                                      email: userState.emailController.text,
                                      password:
                                          userState.passwordController.text,
                                    );

                                    //TODO: handle errors
                                    if (res.error != null || res.user == null) {
                                      print('Error al realizar la petición');
                                      print(res.error!.message);
                                      return;
                                    }

                                    print(res.user!.email);

                                    if (userState.recuerdame == true) {
                                      await userState.setEmail();
                                      //TODO: quitar?
                                      await userState.setPassword();
                                    } else {
                                      userState.emailController.text = '';
                                      userState.passwordController.text = '';
                                      await prefs.remove('email');
                                      await prefs.remove('password');
                                    }

                                    if (!mounted) return;
                                    await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  },
                                  text: 'Ingresar',
                                  options: ButtonOptions(
                                    width: 170,
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

                              // Center(
                              //   child: Padding(
                              //     padding: const EdgeInsetsDirectional.fromSTEB(
                              //         0, 20, 0, 0),
                              //     child: Material(
                              //       color: Colors.transparent,
                              //       elevation: 15,
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(12),
                              //       ),
                              //       child: Container(
                              //         width: 400,
                              //         height: 60,
                              //         decoration: BoxDecoration(
                              //           gradient: const LinearGradient(
                              //             colors: [
                              //               Color(0xFF188001),
                              //               Color(0xFF39D24A)
                              //             ],
                              //             stops: [0, 0.6],
                              //             begin: AlignmentDirectional(1, 0),
                              //             end: AlignmentDirectional(-1, 0),
                              //           ),
                              //           borderRadius: BorderRadius.circular(12),
                              //         ),
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.max,
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             const Padding(
                              //               padding:
                              //                   EdgeInsetsDirectional.fromSTEB(
                              //                       0, 0, 10, 0),
                              //               child: Icon(
                              //                 Icons.login_rounded,
                              //                 color: Colors.white,
                              //                 size: 35,
                              //               ),
                              //             ),
                              //             Text(
                              //               'INICIAR SESIÓN',
                              //               textAlign: TextAlign.end,
                              //               style: AppTheme.of(context)
                              //                   .bodyText1
                              //                   .override(
                              //                     fontFamily: 'Poppins',
                              //                     color: Colors.white,
                              //                     fontSize: 25,
                              //                   ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Recordarme',
                                      style: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    ToggleIcon(
                                      onPressed: () async {
                                        userState.updateRecuerdame();
                                      },
                                      value: userState.recuerdame,
                                      onIcon: const Icon(
                                        Icons.check_box,
                                        color: Color(0xFF12DE29),
                                        size: 30,
                                      ),
                                      offIcon: const Icon(
                                        Icons.check_box_outline_blank,
                                        color: Color(0xFF21882C),
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    40, 20, 40, 0),
                                child: InkWell(
                                  onTap: () => Flurorouter.router.navigateTo(
                                    context,
                                    Flurorouter.resetPassword,
                                  ),
                                  child: Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFFB8B8B8),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15, 20, 15, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: FaIcon(
                                            FontAwesomeIcons.shieldHalved,
                                            color: Color(0xFFA5A5A5),
                                            size: 60,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 10, 0),
                                          child: Text(
                                            'Acceso\nseguro',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color:
                                                      const Color(0xFFA5A5A5),
                                                  fontSize: 20,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 2,
                                      height: 90,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFA5A5A5),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 0, 2),
                                      child: Text(
                                        'La seguridad es nuestra prioridad, \npara ello utilizamos los estándares \nmás altos.',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFFA5A5A5),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
