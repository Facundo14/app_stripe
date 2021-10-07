import 'package:app_stripe/data/tarjetas.dart';
import 'package:app_stripe/helpers/helpers.dart';
import 'package:app_stripe/pages/tarjeta_page.dart';
import 'package:app_stripe/widgets/total_pay_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pagar'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                // mostrarLoading(context);
                // await Future.delayed(Duration(seconds: 1));
                // Navigator.pop(context);
                mostrarAlerta(context, 'Hola', 'Mundo');
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              width: size.width,
              height: size.height,
              top: size.height * 0.25,
              child: PageView.builder(
                controller: PageController(
                  viewportFraction: 0.9,
                ),
                itemCount: tarjetas.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) {
                  final tarjeta = tarjetas[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, navegarMapaFadeIn(context, const TarjetaPage()));
                    },
                    child: Hero(
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
                  );
                },
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
