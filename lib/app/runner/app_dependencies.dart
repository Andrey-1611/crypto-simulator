import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talkerProvider = Provider((_) => TalkerFlutter.init());
final dioProvider = Provider((_) => Dio());
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final authProvider = Provider((_) => FirebaseAuth.instance);
final prefsProvider = FutureProvider(
      (ref) async => await SharedPreferences.getInstance(),
);
final googleProvider = Provider((_) => GoogleSignIn());
final packageProvider = FutureProvider(
      (_) async => await PackageInfo.fromPlatform(),
);

final shareProvider = Provider((_) => SharePlus.instance);
