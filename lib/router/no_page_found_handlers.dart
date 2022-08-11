import 'dart:html';

import 'package:arux/pages/pages.dart';
import 'package:fluro/fluro.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    print('Entered NoPageFound handler');
    print('URL: ${window.location.href}');
    print('Params: $params');
    return const PageNotFoundPage();
  });
}
