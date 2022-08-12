import 'package:arux/pages/widgets/drop_down.dart';
import 'package:arux/pages/widgets/toggle_icon.dart';
import 'package:flutter/material.dart';
import 'package:arux/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AltaUsuarioPage extends StatefulWidget {
  const AltaUsuarioPage({Key? key}) : super(key: key);

  @override
  State<AltaUsuarioPage> createState() => _AltaUsuarioPageState();
}

class _AltaUsuarioPageState extends State<AltaUsuarioPage> {
  String? dropDownValue1 = '';
  TextEditingController textController1 = TextEditingController();
  String? dropDownValue2 = '';
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  String? dropDownValue3 = '';
  String? dropDownValue4 = '';
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();
  TextEditingController textController6 = TextEditingController();
  TextEditingController textController7 = TextEditingController();
  TextEditingController textController8 = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                Container(
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/1e2wnRecurso_6fb.png',
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                100, 20, 50, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Nuestro Trabajo',
                                  style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Gotham',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                      ),
                                ),
                                Text(
                                  'Reseñas',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Gotham',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                          ),
                                ),
                                Text(
                                  'Proveedores',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Gotham',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                          ),
                                ),
                                Text(
                                  'Conócenos',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Gotham',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: false,
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: FaIcon(
                                FontAwesomeIcons.powerOff,
                                color: Color(0xFF09A963),
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 15, 0),
                              child: Container(
                                width: 60,
                                height: 60,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/607/600',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 50, 0),
                                child: Text(
                                  'Luis L.',
                                  style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).alternate,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Color(0xFFBAB8B8),
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: Color(0xFF09A963),
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: Text(
                              'Alta de Usuarios',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham',
                                    color: const Color(0xFF09A963),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 25, 0),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).primaryBackground,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF09A963),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.cleaning_services,
                                    color: Color(0xFF09A963),
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 50, 0),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFF09A963),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF09A963),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.file_download,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 15, 0),
                            child: Container(
                              width: 250,
                              height: 55,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).primaryBackground,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFF09A963),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: Icon(
                                          Icons.search,
                                          color: Color(0xFF09A963),
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 0, 0),
                                          child: TextFormField(
                                            controller: textController1,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: 'Buscar',
                                              hintStyle: AppTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: AppTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: AppTheme.of(context)
                                                      .primaryText,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 15, 0),
                            child: Container(
                              width: 150,
                              height: 45,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).primaryBackground,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFF09A963),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 2, 0, 2),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            FaIcon(
                                              FontAwesomeIcons
                                                  .solidSquareCaretUp,
                                              color: Color(0xFF09A963),
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            FaIcon(
                                              FontAwesomeIcons
                                                  .solidSquareCaretDown,
                                              color: Color(0xFF09A963),
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 0, 0, 0),
                                        child: Text(
                                          'Filas: 20',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Gotham',
                                                color: const Color(0xFF09A963),
                                                fontSize: 18,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).primaryBackground,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF09A963),
                                width: 1.5,
                              ),
                            ),
                            child: CustomDropDown(
                              options: const ['Option 1'],
                              onChanged: (val) =>
                                  setState(() => dropDownValue1 = val),
                              width: 180,
                              height: 50,
                              textStyle:
                                  AppTheme.of(context).bodyText1.override(
                                        fontFamily: 'Gotham',
                                        color: const Color(0xFF09A963),
                                        fontSize: 18,
                                        useGoogleFonts: false,
                                      ),
                              hintText: 'País',
                              fillColor: AppTheme.of(context).primaryBackground,
                              elevation: 2,
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              borderRadius: 30,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  12, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/306/600',
                                  ),
                                ),
                                Container(
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
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      FaIcon(
                                        FontAwesomeIcons.trashCan,
                                        color: Color(0xFF09A963),
                                        size: 20,
                                      ),
                                    ],
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
                                  controller: textController2,
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
                                    hintText: 'Nombre*',
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
                                  controller: textController3,
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
                                    hintText: 'Correo*',
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
                                options: const ['Option 1'],
                                onChanged: (val) =>
                                    setState(() => dropDownValue2 = val),
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
                                hintText: 'País',
                                fillColor:
                                    AppTheme.of(context).primaryBackground,
                                elevation: 2,
                                borderColor: const Color(0xFF09A963),
                                borderWidth: 1.5,
                                borderRadius: 0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
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
                                    setState(() => dropDownValue3 = val),
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
                                hintText: 'Rol*',
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
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
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
                                  controller: textController4,
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
                                    hintText: 'Apellidos*',
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
                                  controller: textController5,
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
                                  controller: textController6,
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Permisos',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              fontSize: 22,
                                            ),
                                  ),
                                ],
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
                                          //TODO: agregar funcionalidad
                                          // setState(() =>
                                          //     FFAppState().recuerdameOn =
                                          //         !FFAppState().recuerdameOn);
                                        },
                                        value: false,
                                        // FFAppState().recuerdameOn,
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
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ToggleIcon(
                                        onPressed: () async {
                                          //TODO: agregar funcionalidad
                                          // setState(() =>
                                          //     FFAppState().recuerdameOn =
                                          //         !FFAppState().recuerdameOn);
                                        },
                                        value: false,
                                        //  FFAppState().recuerdameOn,
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
                                  controller: textController7,
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
                                  controller: textController8,
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
                                    setState(() => dropDownValue4 = val),
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
