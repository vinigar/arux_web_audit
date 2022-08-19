import 'package:arux/helpers/supabase/queries.dart';
import 'package:arux/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

const storage = FlutterSecureStorage();

final supabase = Supabase.instance.client;

late final SharedPreferences prefs;

GlobalKey globalKey = GlobalKey();

Usuario? currentUser;

Future<void> initGlobals() async {
  prefs = await SharedPreferences.getInstance();
  currentUser = await SupabaseQueries.getCurrentUserData();
}
