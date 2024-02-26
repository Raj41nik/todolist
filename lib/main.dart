import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/Home.dart';
import 'package:todolist/auth/authscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAdIf9vY_lGb3u0kjQ8t1CD0ezI-nYgBOM',
        appId: '1:482552513014:android:0582328f5f58bc005807d7',
        messagingSenderId: '482552513014',
        projectId: 'todolist-392c1')
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
        builder:  (context, usersnapshot) {
          if (usersnapshot.hasData) {
            return Home();
          } else {
            return Authscreen();
          }
        },

      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffa1c4fd),
          foregroundColor: Color(0xffebedee)
        ),
          brightness: Brightness.light,
          primaryColor:Color(0xffa1c4fd)),

    );
  }
}
