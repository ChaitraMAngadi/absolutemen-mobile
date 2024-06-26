import 'package:absolutemen_app/autentication/provider/authentication_provider.dart';
import 'package:absolutemen_app/home_page/provider/home_page_provider.dart';
import 'package:absolutemen_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomePageProvider()),
    ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Absolutemen_app',
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}
