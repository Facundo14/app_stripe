import 'dart:io';

import 'package:app_stripe/bloc/pagar/pagar_bloc.dart';
import 'package:app_stripe/helpers/helpers.dart';
import 'package:app_stripe/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButtom extends StatelessWidget {
  const TotalPayButtom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagarBloc = BlocProvider.of<PagarBloc>(context).state;
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.12,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.bold),
              ),
              Text(
                '${pagarBloc.moneda} ${pagarBloc.montoPagar}',
                style: TextStyle(fontSize: size.width * 0.045),
              ),
            ],
          ),
          const _BtnPay()
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {
  const _BtnPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool tarjetaActiva = BlocProvider.of<PagarBloc>(context).state.tarjetaActiva;
    return tarjetaActiva ? buildBotonTarjeta(context) : buildAppleAndGooglePay(context);
  }

  Widget buildBotonTarjeta(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialButton(
      height: size.height * 0.05,
      minWidth: size.width * 0.3,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.solidCreditCard,
            color: Colors.white,
          ),
          Text('   Pagar', style: TextStyle(color: Colors.white, fontSize: size.width * 0.04)),
        ],
      ),
      onPressed: () async {
        mostrarLoading(context);
        final stripeService = StripeService();
        final pagarBlocState = context.read<PagarBloc>().state;

        final mesAnio = pagarBlocState.tarjeta.expiracyDate.split('/');

        final resp = await stripeService.pagarConTarjetaExiste(
          amount: pagarBlocState.montoPagarString,
          currency: pagarBlocState.moneda,
          card: CreditCard(
            number: pagarBlocState.tarjeta.cardNumber,
            expMonth: int.parse(mesAnio[0]),
            expYear: int.parse(mesAnio[1]),
          ),
        );
        Navigator.pop(context);
        if (resp.ok) {
          mostrarAlerta(context, 'Tarjeta Ok', 'Todo Correcto');
        } else {
          mostrarAlerta(context, 'Algo salio mal', resp.msg);
        }
      },
    );
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialButton(
      height: size.height * 0.05,
      minWidth: size.width * 0.3,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isAndroid ? FontAwesomeIcons.google : FontAwesomeIcons.apple,
            color: Colors.white,
          ),
          Text('   Pagar', style: TextStyle(color: Colors.white, fontSize: size.width * 0.04)),
        ],
      ),
      onPressed: () async {
        mostrarLoading(context);
        final stripeService = StripeService();
        final pagarBlocState = context.read<PagarBloc>().state;


        final resp = await stripeService.pagarApplePayGooglePay(
          amount: pagarBlocState.montoPagarString,
          currency: pagarBlocState.moneda,
         
        );
        Navigator.pop(context);
        if (resp.ok) {
          mostrarAlerta(context, 'Tarjeta Ok', 'Todo Correcto');
        } else {
          mostrarAlerta(context, 'Algo salio mal', resp.msg);
        }
      },
    );
  }
}
