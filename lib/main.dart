import 'package:flutter/material.dart';
import 'package:lojavirtualapp/dependencies/app_components.dart';
import 'package:lojavirtualapp/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppComponents.initApp();

  runApp(const MyApp());
}
