import 'package:arux/pages/widgets/custom_button.dart';
import 'package:arux/theme/theme.dart';
import 'package:flutter/material.dart';

class DetalleFacturaPopup extends StatelessWidget {
  const DetalleFacturaPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        color: const Color(0xFF09A963),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.of(context).primaryColor,
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10, 10, 10, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Detalle de Factura',
                                style: AppTheme.of(context).title1.override(
                                      fontFamily: 'Gotham',
                                      color: AppTheme.of(context)
                                          .secondaryBackground,
                                      fontSize: 35,
                                      useGoogleFonts: false,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 10, 0),
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 10, 20),
                              child: Text(
                                'Detalle de la factura F-2324 por',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham',
                                      color: AppTheme.of(context).textosVerdes,
                                      fontSize: 20,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 10, 20),
                              child: Text(
                                '-1,261,662.00 USD',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham',
                                      color: AppTheme.of(context).textosVerdes,
                                      fontSize: 20,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Nota. de Crédito:',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Gotham',
                                              color: AppTheme.of(context)
                                                  .textosVerdes,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 0, 0),
                                        child: Text(
                                          '12345',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Gotham',
                                                color: AppTheme.of(context)
                                                    .textoAlternativo,
                                                fontWeight: FontWeight.w300,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Porcentaje de descuento:',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Gotham',
                                                color: AppTheme.of(context)
                                                    .textosVerdes,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(5, 0, 0, 0),
                                          child: Text(
                                            '9%',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Gotham',
                                                  color: AppTheme.of(context)
                                                      .textoAlternativo,
                                                  fontWeight: FontWeight.w300,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Fecha de contabilización:',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Gotham',
                                                color: AppTheme.of(context)
                                                    .textosVerdes,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(5, 0, 0, 0),
                                          child: Text(
                                            '26/06/2022',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Gotham',
                                                  color: AppTheme.of(context)
                                                      .textoAlternativo,
                                                  fontWeight: FontWeight.w300,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Fecha de emisión:',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Gotham',
                                                  color: AppTheme.of(context)
                                                      .textosVerdes,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 0, 0, 0),
                                            child: Text(
                                              '24/06/2022',
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Gotham',
                                                    color: AppTheme.of(context)
                                                        .textoAlternativo,
                                                    fontWeight: FontWeight.w300,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Monto Nota de Crédito:',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Gotham',
                                                color: AppTheme.of(context)
                                                    .textosVerdes,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(5, 0, 0, 0),
                                          child: Text(
                                            '\$111,449.58',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Gotham',
                                                  color: AppTheme.of(context)
                                                      .textoAlternativo,
                                                  fontWeight: FontWeight.w300,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Moneda:',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Gotham',
                                                  color: AppTheme.of(context)
                                                      .textosVerdes,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 0, 0, 0),
                                            child: Text(
                                              'USD',
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Gotham',
                                                    color: AppTheme.of(context)
                                                        .textoAlternativo,
                                                    fontWeight: FontWeight.w300,
                                                    useGoogleFonts: false,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                    child: CustomButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Aceptar',
                      options: ButtonOptions(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 20, 20, 20),
                        color: const Color(0xFF09A963),
                        textStyle: AppTheme.of(context).subtitle2.override(
                              fontFamily: 'Gotham',
                              color: AppTheme.of(context).secondaryBackground,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                        elevation: 2,
                        borderSide: BorderSide(
                          color: AppTheme.of(context).primaryColor,
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
    );
  }
}
