import 'package:flutter/material.dart';
import 'package:sitech_books/app/app.dart';
import 'package:sitech_books/app/utils/service_locator.dart' as locator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await locator.initializeServices();
  return runApp(const SitechBooks());
}
