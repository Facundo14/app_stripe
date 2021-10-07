import 'package:app_stripe/services/stripe_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_stripe/bloc/pagar/pagar_bloc.dart';

import 'package:app_stripe/pages/home_page.dart';
import 'package:app_stripe/pages/pago_completo_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //llamar el init del stripe Service (Singleton)
    // final stripeService = StripeService();
    // stripeService.init;

    //Forma Corta
    StripeService().init();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PagarBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StripeApp',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'pago_completo': (_) => const PagoCompletoPage(),
        },
        theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xff284879),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff284879),
          ),
          scaffoldBackgroundColor: const Color(0xff21232A),
        ),
      ),
    );
  }
}
