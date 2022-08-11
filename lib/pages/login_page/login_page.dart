import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/home_page/home_page.dart';
import 'package:arux/router/router.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:arux/pages/widgets/custom_button.dart';
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(100, 50, 0, 0),
                    child: Image.asset(
                      'assets/images/1e2wnRecurso_2aruxlogoletraswhite.png',
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                        child: Text(
                          'Inicio de sesión',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Bicyclette',
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          controller: userState.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El correo es requerido';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Por favor ingresa un correo válido';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Usuario',
                            hintText: 'Usuario',
                            hintStyle: AppTheme.of(context).bodyText2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            controller: userState.passwordController,
                            obscureText: !passwordVisibility,
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
                              labelText: 'Contraseña',
                              hintText: 'Contraseña',
                              hintStyle:
                                  AppTheme.of(context).bodyText2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 5, 0),
                              child: ToggleIcon(
                                onPressed: () async {
                                  userState.updateRecuerdame();
                                },
                                value: userState.recuerdame,
                                onIcon: const Icon(
                                  Icons.check_circle_outline_sharp,
                                  color: Color(0xFF03C774),
                                  size: 36,
                                ),
                                offIcon: const FaIcon(
                                  FontAwesomeIcons.circle,
                                  color: Color(0xFF03C774),
                                  size: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                'Recordarme',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 5, 0),
                        child: InkWell(
                          onTap: () => Flurorouter.router.navigateTo(
                            context,
                            Flurorouter.resetPassword,
                          ),
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: CustomButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            //Login

                            final res = await supabase.auth.signIn(
                              email: userState.emailController.text,
                              password: userState.passwordController.text,
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
                            width: 200,
                            height: 50,
                            color: const Color(0xFF03C774),
                            textStyle: AppTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 80, 15, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: FaIcon(
                                    FontAwesomeIcons.shieldHalved,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Text(
                                    'Acceso\nseguro',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 2,
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE7E7E7),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 0, 2),
                              child: Text(
                                'La seguridad es nuestra prioridad, por\neso usamos los estándares mas altos.',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFFE7E7E7),
                                      fontSize: 14,
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
      ),
    );
  }
}
