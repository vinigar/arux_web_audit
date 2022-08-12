import 'package:arux/pages/pages.dart';
import 'package:fluro/fluro.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    return const PageNotFoundPage();
  });
}
