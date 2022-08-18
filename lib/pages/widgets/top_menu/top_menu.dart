import 'package:arux/theme/theme.dart';
import 'package:flutter/material.dart';

class TopMenuWidget extends StatelessWidget {
  const TopMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/1e2wnRecurso_6fb.png',
                height: 40,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //PAIS
                  Text(
                    'Pais: ',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Gotham-Light',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          useGoogleFonts: false,
                        ),
                  ),
                  //ROL
                  Text(
                    'Rol: ',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Gotham-Light',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          useGoogleFonts: false,
                        ),
                  ),
                  //FOTO
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
