import 'package:arux/pages/pages.dart';
import 'package:arux/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // late Future<void> displaySplashImage;
  // @override
  // void initState() {
  //   displaySplashImage = Future.delayed(Duration(seconds: widget.splashTimer));
  //   super.initState();
  // }

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
                child: Builder(
                  builder: (context) => Image.asset(
                    'assets/images/Final_Comp.gif',
                    fit: BoxFit.cover,
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
