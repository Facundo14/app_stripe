part of 'pagar_bloc.dart';

@immutable
class PagarState {
  final double montoPagar;
  final String moneda;
  final bool tarjetaActiva;
  final TarjetaCredito tarjeta;

  String get montoPagarString => '${(montoPagar * 100).floor()}';

  PagarState({
    this.montoPagar = 250,
    this.moneda = 'EUR',
    this.tarjetaActiva = false,
    tarjeta,
  }) : tarjeta = tarjeta ??
            TarjetaCredito(
              cardNumberHidden: '',
              cardNumber: '',
              brand: '',
              cvv: '',
              expiracyDate: '',
              cardHolderName: '',
            );

  PagarState copyWith({
    double? montoPagar,
    String? moneda,
    bool? tarjetaActiva,
    TarjetaCredito? tarjeta,
  }) =>
      PagarState(
        montoPagar: montoPagar ?? this.montoPagar,
        moneda: moneda ?? this.moneda,
        tarjetaActiva: tarjetaActiva ?? this.tarjetaActiva,
        tarjeta: tarjeta ?? this.tarjeta,
      );
}
