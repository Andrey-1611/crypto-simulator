import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talkerProvider = Provider((ref) => TalkerFlutter.init());
final dioProvider = Provider((ref) => Dio());
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final authProvider = Provider((ref) => FirebaseAuth.instance);
final prefsProvider = FutureProvider(
  (ref) async => await SharedPreferences.getInstance(),
);
final googleProvider = Provider((ref) => GoogleSignIn());
final packageProvider = FutureProvider(
  (ref) async => await PackageInfo.fromPlatform(),
);

final connectivityProvider = Provider((ref) => Connectivity());
