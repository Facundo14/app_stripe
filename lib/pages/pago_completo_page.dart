import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PagoCompletoPage extends StatelessWidget {
  const PagoCompletoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago realizado!'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.star,
              color: Colors.white54,
              size: size.width * 0.3,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              'Pago realizado correctamente!',
              style: TextStyle(color: Colors.white, fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
