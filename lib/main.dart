import 'package:absolutemen_app/home_page/home_page.dart';
import 'package:absolutemen_app/provider/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomePageProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Absolutemen_app',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
