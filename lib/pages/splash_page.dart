import 'package:arux/helpers/globals.dart';
import 'package:arux/models/models.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:arux/pages/pages.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    return Scaffold(
      body: Builder(
        builder: (_) {
          final user = supabase.auth.currentUser;
          if (user == null) {
            return const LoginPage();
          } else {
            return FutureBuilder<Usuario?>(
              future: userState.getCurrentUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: SpinKitRipple(
                        color: AppTheme.of(context).primaryColor,
                        size: 50,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: SpinKitRipple(
                        color: AppTheme.of(context).primaryColor,
                        size: 50,
                      ),
                    ),
                  );
                } else {
                  return const UsuariosPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
