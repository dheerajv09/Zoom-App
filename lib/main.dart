import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_app/src/services/auth_service.dart';
import 'package:zoom_app/src/services/firestore_service.dart';
import 'package:zoom_app/src/services/jitsi_meet_service.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => JitsiMeetService()),
        Provider(create: (context) => FirestoreService()),
        StreamProvider(
            create: (context) =>
                context.read<FirestoreService>().meetingsHistory(),
            initialData: null),
        Provider(create: (context) => AuthService()),
        StreamProvider(
            create: (context) => context.read<AuthService>().authChanges,
            initialData: null),
      ],
      child: MyApp(),
    ),
  );
}
