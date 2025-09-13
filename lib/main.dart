import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portifolio/firebase_options.dart';
import 'package:portifolio/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.tealAccent, // highlight background
          selectionHandleColor: Colors.tealAccent, // draggable handles
        ),
      ),
      home: HomePage(),
    );
  }
}
