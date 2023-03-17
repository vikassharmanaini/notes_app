import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/MyHomePage.dart';
import 'package:notes_app/NotesModal.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  var path = await getApplicationSupportDirectory();
  Hive
    ..init(path.path)
    ..registerAdapter(NotesAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(),
    );
  }
}
