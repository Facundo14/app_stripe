import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalPayButtom extends StatelessWidget {
  const TotalPayButtom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                '\$ 25.55',
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
    return true ? buildBotonTarjeta(context) : buildAppleAndGooglePay(context);
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
      onPressed: () {},
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
      onPressed: () {},
    );
  }
}
