import 'dart:io';

import 'package:Mobile_Test/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _appDocsDir = await getApplicationDocumentsDirectory();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'People',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.white,
    ),
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomeScreen(
            directory: _appDocsDir,
          )
    },
  ));
}

Directory _appDocsDir;
