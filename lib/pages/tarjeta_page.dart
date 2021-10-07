import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_stripe/bloc/pagar/pagar_bloc.dart';

import 'package:app_stripe/widgets/total_pay_buttom.dart';

class TarjetaPage extends StatelessWidget {
  const TarjetaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagarBloc = BlocProvider.of<PagarBloc>(context);
    final tarjeta = pagarBloc.state.tarjeta;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pagar'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              pagarBloc.add(OnDesactivarTarjeta());
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: [
            Container(),
            Hero(
              tag: tarjeta.cardNumber,
              child: CreditCardWidget(
                cardNumber: tarjeta.cardNumber,
                isHolderNameVisible: true,
                cardHolderName: tarjeta.cardHolderName,
                isChipVisible: false,
                expiryDate: tarjeta.expiracyDate,
                isSwipeGestureEnabled: false,
                obscureCardNumber: true,
                cvvCode: tarjeta.cvv,
                showBackView: false,
                onCreditCardWidgetChange: (_) {},
              ),
            ),
            const Positioned(
              bottom: 0,
              child: TotalPayButtom(),
            )
          ],
        ));
  }
}
