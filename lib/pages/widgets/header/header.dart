import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:arux/theme/theme.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({
    Key? key,
    required this.headerName,
  }) : super(key: key);

  final String headerName;

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  TextEditingController searchController = TextEditingController();
  String? currPaisDropValue = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
                child: InkWell(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Color(0xFF09A963),
                    size: 30,
                  ),
                ),
              ),
              Text(
                widget.headerName,
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Bicyclette-Light',
                      color: const Color(0XFF04C774),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts: false,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
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
                  child: const Icon(
                    Icons.cleaning_services,
                    color: Color(0xFF09A963),
                    size: 28,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
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
                  child: const Icon(
                    Icons.file_download,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
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
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF09A963),
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: TextFormField(
                            controller: searchController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Buscar',
                              hintStyle:
                                  AppTheme.of(context).bodyText2.override(
                                        fontFamily: 'Gotham-Light',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                      ),
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
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Gotham-Light',
                                  color: AppTheme.of(context).primaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: false,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
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
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 2, 0, 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.solidSquareCaretUp,
                              color: Color(0xFF09A963),
                              size: 15,
                            ),
                            FaIcon(
                              FontAwesomeIcons.solidSquareCaretDown,
                              color: Color(0xFF09A963),
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          'Filas: 20',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Gotham-Light',
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
