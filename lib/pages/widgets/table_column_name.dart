import 'package:arux/theme/theme.dart';
import 'package:flutter/material.dart';

class TableColumnName extends StatelessWidget {
  const TableColumnName({
    Key? key,
    required this.nombre,
  }) : super(key: key);

  final String nombre;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nombre,
          textAlign: TextAlign.center,
          style: AppTheme.of(context).subtitle1.override(
                fontFamily: 'Bicyclette-Bold',
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
          child: Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }
}
