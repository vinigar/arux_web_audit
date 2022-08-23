import 'package:arux/helpers/supabase/queries.dart';
import 'package:arux/pages/widgets/custom_button.dart';
import 'package:arux/theme/theme.dart';
import 'package:flutter/material.dart';

class PopupNotaCredito extends StatefulWidget {
  const PopupNotaCredito({
    Key? key,
    required this.partidasSapId,
  }) : super(key: key);

  final int partidasSapId;

  @override
  State<PopupNotaCredito> createState() => _PopupNotaCreditoState();
}

class _PopupNotaCreditoState extends State<PopupNotaCredito> {
  final formKey = GlobalKey<FormState>();
  TextEditingController ncFolioController = TextEditingController();
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
          width: MediaQuery.of(context).size.width * 0.3,
          height: 275,
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Builder(builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
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
                      width: MediaQuery.of(context).size.width * 0.3,
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
                                'Nota de Crédito',
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 10, 20),
                          child: Text(
                            'Ingresa el folio de la Nota de Crédito',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Gotham',
                                  color: AppTheme.of(context).textosVerdes,
                                  fontSize: 20,
                                  useGoogleFonts: false,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 10, 0),
                              child: Text(
                                'Nota de Crédito*',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham',
                                      color: AppTheme.of(context).textosVerdes,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: ncFolioController,
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El folio es requerido';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).textosVerdes,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).textosVerdes,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 15, 0),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham',
                                      color:
                                          AppTheme.of(context).textoAlternativo,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 10),
                    child: CustomButton(
                      onPressed: () async {
                        // if (!formKey.currentState!.validate()) {
                        //   return;
                        // }
                        await SupabaseQueries.insertNc(
                          widget.partidasSapId,
                          ncFolioController.text,
                        );

                        if (!mounted) return;
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
