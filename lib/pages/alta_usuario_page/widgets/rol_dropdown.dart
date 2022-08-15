import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:arux/pages/widgets/drop_down.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/theme/theme.dart';

class RolDropDown extends StatefulWidget {
  const RolDropDown({Key? key}) : super(key: key);

  @override
  State<RolDropDown> createState() => _RolDropDownState();
}

class _RolDropDownState extends State<RolDropDown> {
  String? rolDropValue = '';

  @override
  Widget build(BuildContext context) {
    final CrudUsuarios usuarios = Provider.of<CrudUsuarios>(context);

    return FutureBuilder<List<String>>(
      future: usuarios.getRoles(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<String> roles = snapshot.data!;
          return CustomDropDown(
            options: roles,
            onChanged: (val) => setState(() {
              rolDropValue = val;
              usuarios.setRol(val);
            }),
            width: 500,
            height: 70,
            textStyle: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Montserrat',
                  color: AppTheme.of(context).primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
            hintText: 'Rol*',
            fillColor: AppTheme.of(context).primaryBackground,
            elevation: 1,
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
