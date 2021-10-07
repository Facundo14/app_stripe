import 'package:flutter/material.dart';
import 'package:app_stripe/pages/home_page.dart';
import 'package:app_stripe/pages/pago_completo_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StripeApp',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'pago_completo': (_) => const PagoCompletoPage(),
      },
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xff284879),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff284879),
        ),
        scaffoldBackgroundColor: const Color(0xff21232A),
      ),
    );
  }
}
