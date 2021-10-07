import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:app_stripe/models/tarjeta_credito.dart';

import 'package:app_stripe/widgets/total_pay_buttom.dart';

class TarjetaPage extends StatelessWidget {
  const TarjetaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tarjeta = TarjetaCredito(
        cardNumberHidden: '4242',
        cardNumber: '4242424242424242',
        brand: 'visa',
        cvv: '213',
        expiracyDate: '01/25',
        cardHolderName: 'Fernando Herrera');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pagar'),
          centerTitle: true,
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
