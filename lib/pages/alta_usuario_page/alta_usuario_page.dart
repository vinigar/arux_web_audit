import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart' as provider;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:arux/pages/widgets/get_image_widget.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/helpers/constants.dart';
import 'package:arux/helpers/globals.dart';
import 'package:arux/pages/widgets/header/header.dart';
import 'package:arux/pages/alta_usuario_page/widgets/pais_dropdown.dart';
import 'package:arux/pages/widgets/custom_button.dart';
import 'package:arux/pages/widgets/drop_down.dart';
import 'package:arux/pages/widgets/top_menu/top_menu.dart';
import 'package:arux/pages/widgets/toggle_icon.dart';
import 'package:arux/pages/alta_usuario_page/widgets/rol_dropdown.dart';
import 'package:arux/theme/theme.dart';

class AltaUsuarioPage extends StatefulWidget {
  const AltaUsuarioPage({Key? key}) : super(key: key);

  @override
  State<AltaUsuarioPage> createState() => _AltaUsuarioPageState();
}

class _AltaUsuarioPageState extends State<AltaUsuarioPage> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController extController = TextEditingController();
  TextEditingController proveedorController = TextEditingController();
  TextEditingController nombreProveedorController = TextEditingController();

  String? cuentasDropValue = '';

  bool adminCheckbox = false;
  bool capturaCheckbox = false;

  Uint8List? webImage;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CrudUsuarios usuarios = provider.Provider.of<CrudUsuarios>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                //MENU
                const TopMenuWidget(),

                //DIVIDER
                const Divider(
                  height: 2,
                  color: Color(0xFFBAB8B8),
                  thickness: 1,
                ),

                //HEADER ALTA DE USUARIOS
                const PageHeader(headerName: 'Alta de Usuarios'),

                //Formulario
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();

                                      final XFile? pickedImage =
                                          await picker.pickImage(
                                        source: ImageSource.gallery,
                                      );

                                      if (pickedImage == null) {
                                        return;
                                      }

                                      webImage =
                                          await pickedImage.readAsBytes();

                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: getUserImage(webImage),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      webImage = null;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context)
                                            .secondaryBackground,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF09A963),
                                          width: 2,
                                        ),
                                      ),
                                      child: const Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.trashCan,
                                          color: Color(0xFF09A963),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Container(
                                  width: 500,
                                  decoration: const BoxDecoration(),
                                  child: TextFormField(
                                    controller: nombreController,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Gotham',
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                          ),
                                      hintText: 'Nombre*',
                                      hintStyle: AppTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF09A963),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF09A963),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Container(
                                  width: 500,
                                  decoration: const BoxDecoration(),
                                  child: TextFormField(
                                    controller: apellidosController,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Gotham',
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                          ),
                                      hintText: 'Apellidos*',
                                      hintStyle: AppTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF09A963),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF09A963),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Container(
                                  width: 500,
                                  decoration: const BoxDecoration(),
                                  child: TextFormField(
                                    controller: correoController,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Gotham',
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                          ),
                                      hintText: 'Correo*',
                                      hintStyle: AppTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: AppTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF09A963),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF09A963),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: PaisesDropDown(),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: RolDropDown(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Container(
                                width: 500,
                                decoration: const BoxDecoration(),
                                child: TextFormField(
                                  controller: telefonoController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Gotham',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: false,
                                        ),
                                    hintText: 'Teléfono*',
                                    hintStyle: AppTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Container(
                                width: 500,
                                decoration: const BoxDecoration(),
                                child: TextFormField(
                                  controller: extController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Gotham',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: false,
                                        ),
                                    hintText: 'Ext:',
                                    hintStyle: AppTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  230, 30, 230, 0),
                              child: Text(
                                'Permisos',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  230, 0, 230, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ToggleIcon(
                                        onPressed: () async {
                                          setState(() =>
                                              adminCheckbox = !adminCheckbox);
                                        },
                                        value: adminCheckbox,
                                        onIcon: const Icon(
                                          Icons.check_box,
                                          color: Color(0xFF09A963),
                                          size: 25,
                                        ),
                                        offIcon: const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Color(0xFF09A963),
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        'Administrador',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Gotham',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontSize: 18,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ToggleIcon(
                                        onPressed: () async {
                                          setState(() => capturaCheckbox =
                                              !capturaCheckbox);
                                        },
                                        value: capturaCheckbox,
                                        onIcon: const Icon(
                                          Icons.check_box,
                                          color: Color(0xFF09A963),
                                          size: 25,
                                        ),
                                        offIcon: const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Color(0xFF09A963),
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        'Captura',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Gotham',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontSize: 18,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Container(
                                width: 500,
                                decoration: const BoxDecoration(),
                                child: TextFormField(
                                  controller: proveedorController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Gotham',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: false,
                                        ),
                                    hintText: 'Proveedor*',
                                    hintStyle: AppTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Container(
                                width: 500,
                                decoration: const BoxDecoration(),
                                child: TextFormField(
                                  controller: nombreProveedorController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Gotham',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: false,
                                        ),
                                    hintText: 'Nombre:',
                                    hintStyle: AppTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF09A963),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: CustomDropDown(
                                options: const [
                                  'Proveedor',
                                  'Especialista en tesorería',
                                  'Administrador',
                                  'OLS Validación'
                                ],
                                onChanged: (val) =>
                                    setState(() => cuentasDropValue = val),
                                width: 500,
                                height: 70,
                                textStyle: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                hintText: 'Cuentas*',
                                fillColor:
                                    AppTheme.of(context).primaryBackground,
                                elevation: 1,
                                borderColor: const Color(0xFF09A963),
                                borderWidth: 1.5,
                                borderRadius: 0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomButton(
                                onPressed: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  //TODO: add validations

                                  if (webImage != null) {
                                    final storageResponse = await supabase
                                        .storage
                                        .from('avatars')
                                        .uploadBinary(
                                          'public/avatar1.png',
                                          webImage!,
                                          fileOptions: const FileOptions(
                                            cacheControl: '3600',
                                            upsert: false,
                                          ),
                                        );
                                    if (storageResponse.hasError) {
                                      print(storageResponse.error!.message);
                                      print(storageResponse.error!.error);
                                      print('Error al subir imagen.');
                                    }
                                  }

                                  final res = await supabase.auth.signUp(
                                    correoController.text,
                                    'default',
                                  );

                                  if (res.error != null) {
                                    print('Error al realizar la petición');
                                    print(res.error!.message);
                                    return;
                                  }

                                  if (res.data == null) return;
                                  if (res.data?.user == null) return;

                                  final res2 = await supabase
                                      .from('perfil_usuario')
                                      .insert(
                                    {
                                      'perfil_usuario_id': res.data!.user!.id,
                                      'nombre': nombreController.text,
                                      'apellidos': apellidosController.text,
                                      'id_pais_fk': usuarios.paisId,
                                      'id_rol_fk': usuarios.rolId,
                                      'id_proveedor_fk': usuarios.proveedorId,
                                      'cuentas': cuentasDropValue,
                                      'telefono': telefonoController.text,
                                      'imagen': '',
                                    },
                                  ).execute();

                                  if (res2.error != null) {
                                    print('Error al realizar la petición');
                                    print(res2.error!.message);
                                    return;
                                  }

                                  final res3 = await supabase.auth.signIn(
                                    email: correoController.text,
                                    options: AuthOptions(
                                      redirectTo: redirectUrl,
                                    ),
                                  );

                                  // //TODO: handle errors
                                  if (res3.error != null) {
                                    print('Error al realizar la petición');
                                    print(res.error!.message);
                                    return;
                                  }

                                  if (!mounted) return;
                                  // await Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const HomePage(),
                                  //   ),
                                  // );
                                },
                                text: 'Crear usuario',
                                options: ButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color: const Color(0xFF03C774),
                                  textStyle:
                                      AppTheme.of(context).subtitle2.override(
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
                          ],
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
    );
  }
}
