import 'package:alquran_app/core/services/http_client.dart';
import 'package:alquran_app/core/services/local_database_client.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class InjectableModules {
  @preResolve
  Future<SharedPreferences> get prefs async => SharedPreferences.getInstance();

  @lazySingleton
  FirebaseAuth get authClient => FirebaseAuth.instance;

  @lazySingleton
  FirebaseStorage get storageClient => FirebaseStorage.instance;

  @lazySingleton
  FirebaseFirestore get dbClient => FirebaseFirestore.instance;

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  Dio get dio => HttpClient.instance;

  @injectable
  AudioPlayer get audioPlayer => AudioPlayer();

  @preResolve
  Future<Database> get localDbClient async => LocalDatabaseClient.instance;
}
