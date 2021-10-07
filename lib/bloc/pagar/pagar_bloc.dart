import 'package:app_stripe/models/tarjeta_credito.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(PagarState()) {
    on<OnSeleccionarTarjeta>(_onSeleccionarTarjeta);
    on<OnDesactivarTarjeta>(_onDesactivarTarjeta);
  }

  _onSeleccionarTarjeta(OnSeleccionarTarjeta event, Emitter<PagarState> emit) {
    emit(state.copyWith(tarjetaActiva: true, tarjeta: event.tarjeta));
  }

  _onDesactivarTarjeta(OnDesactivarTarjeta event, Emitter<PagarState> emit) {
    emit(state.copyWith(tarjetaActiva: false));
  }
}
