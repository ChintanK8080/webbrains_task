import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webbrains_task/firebase_options.dart';
import 'package:webbrains_task/routes/bindings.dart';
import 'package:webbrains_task/routes/routes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  UserBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: routes,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'UK'),
      initialRoute: Routes.splash,
      initialBinding: UserBindings(),
    );
  }
}
