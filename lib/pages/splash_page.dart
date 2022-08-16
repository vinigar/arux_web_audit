import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:arux/pages/pages.dart';
import 'package:arux/providers/providers.dart';
import 'package:arux/theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
    this.splashTimer = 6,
  }) : super(key: key);

  final int splashTimer;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Future.wait([
            userState.readToken(),
            // displaySplashImage,
          ]),
          builder: (_, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.transparent,
                child: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SpinKitCircle(
                      color: AppTheme.of(context).secondaryColor,
                      size: 50,
                    ),
                  ),
                ),
              );
            }
            if (snapshot.data![0] == '') {
              return const LoginPage();
            } else {
              return const Text('Home Page');
              // return const EmprendimientosScreen();
            }
          },
        ),
      ),
    );
  }
}
