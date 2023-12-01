import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'app/view/app.dart';
import 'data/service_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Initialize the [GetIt] service locator.
  await initLocator();

  runApp(
    App(
      logRepository: locator(),
      authenticationRepository: locator(),
    ),
  );
}
