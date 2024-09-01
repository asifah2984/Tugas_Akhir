import 'dart:async';
import 'dart:developer';
import 'package:alquran_app/core/injection/injection.dart';
import 'package:alquran_app/core/utils/logger.dart';
import 'package:alquran_app/firebase_options.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.debug('onEvent(${bloc.runtimeType}, $event)');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLogger.debug('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.error('onError(${bloc.runtimeType}, $error, $stackTrace)');
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
) async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // show load flutter engine splash replacement
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // initializes Firebase services
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initializes Firebase AppCheck
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  );

  // initializes dependencies
  await initDependencies();

  // remove load flutter engine splash replacement
  FlutterNativeSplash.remove();

  runApp(await builder());
}
