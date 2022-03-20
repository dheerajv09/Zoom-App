import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_app/src/services/auth_service.dart';
import 'package:zoom_app/src/screens/home_screen.dart';
import 'package:zoom_app/src/screens/login_screen.dart';
import 'package:zoom_app/src/screens/video_call_screen.dart';
import 'package:zoom_app/src/utils/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      title: 'Zoom Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      darkTheme: ThemeData.dark(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/video-call': (context) => const VideoCallScreen(),
      },
      home: StreamBuilder(
        stream: context.watch<AuthService>().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return HomeScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
