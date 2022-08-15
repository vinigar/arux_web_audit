import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:arux/pages/widgets/drop_down.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/theme/theme.dart';

class PaisesDropDown extends StatefulWidget {
  const PaisesDropDown({Key? key}) : super(key: key);

  @override
  State<PaisesDropDown> createState() => _PaisesDropDownState();
}

class _PaisesDropDownState extends State<PaisesDropDown> {
  String? paisDropValue = '';

  @override
  Widget build(BuildContext context) {
    final CrudUsuarios usuarios = Provider.of<CrudUsuarios>(context);

    return FutureBuilder<List<String>>(
      future: usuarios.getPaises(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<String> paises = snapshot.data!;
          return CustomDropDown(
            options: paises,
            onChanged: (val) => setState(() {
              paisDropValue = val;
              usuarios.setPais(val);
            }),
            width: 500,
            height: 70,
            textStyle: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  color: AppTheme.of(context).primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
            hintText: 'País',
            fillColor: AppTheme.of(context).primaryBackground,
            elevation: 2,
            borderColor: const Color(0xFF09A963),
            borderWidth: 1.5,
            borderRadius: 0,
            margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            hidesUnderline: true,
          );
        } else {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitCircle(
                color: AppTheme.of(context).secondaryColor,
                size: 50,
              ),
            ),
          );
        }
      },
    );
  }
}
