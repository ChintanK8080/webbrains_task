import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webbrains_task/firebase_options.dart';
import 'package:webbrains_task/view/screen/login_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
