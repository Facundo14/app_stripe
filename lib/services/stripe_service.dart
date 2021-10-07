import 'package:app_stripe/models/payment_intent_response.dart';
import 'package:dio/dio.dart';
import 'package:app_stripe/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  //Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();

  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey = 'sk_test_51JhwEJF2K4WvjaQeMiNM0Lbc060GU4meWKRWndvNI1zd0flCEzGQ2YATcYtP45dovnfXpyYyPxPflrzcEcj54lZV00Hng6oBjj';
  String _apiKey = 'pk_test_51JhwEJF2K4WvjaQecdtCiT4nJEIXDD8xgOdxEUacJWqWUPRHMETCLQx3dHgvNhmPgcmk2QGpFr9zrw73MYQxJA0m00ozhcvsL3';

  final headersOptions = Options(contentType: Headers.formUrlEncodedContentType, headers: {
    'Authorization': 'Bearer ${StripeService._secretKey}',
  });

  void init() {
    StripePayment.setOptions(StripeOptions(
      publishableKey: _apiKey,
      androidPayMode: 'test',
      merchantId: 'test',
    ));
  }

  Future<StripeCustomResponse> pagarConTarjetaExiste({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card),
      );

      final resp = await _realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<StripeCustomResponse> pagarConNuevaTarjeta({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      final resp = await _realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<StripeCustomResponse> pagarApplePayGooglePay({
    required String amount,
    required String currency,
  }) async {
    try {
      final newAmount = double.parse(amount) / 100;
      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: currency,
          totalPrice: amount,
        ),
        applePayOptions: ApplePayPaymentOptions(
          countryCode: 'US',
          currencyCode: currency,
          items: [
            ApplePayItem(
              label: 'Nombre del articulo',
              amount: '$newAmount',
            )
          ],
        ),
      );

      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            token: token.tokenId,
          ),
        ),
      );

      final resp = await _realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

      //Cerrar pantalla en IOS al completar el pago
      await StripePayment.completeNativePayRequest();

      return resp;
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

  Future<PaymentIntentResponse> _crearPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      final dio = Dio();

      final data = {'amount': amount, 'currency': currency};

      final resp = await dio.post(_paymentApiUrl, data: data, options: headersOptions);

      return PaymentIntentResponse.fromJson(resp.data);
    } catch (e) {
      print('Error en intento: ${e.toString()}');
      return PaymentIntentResponse(
        status: '400',
      );
    }
  }

  Future<StripeCustomResponse> _realizarPago({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod,
  }) async {
    try {
      //Crear Intento
      final paymentIntent = await _crearPaymentIntent(
        amount: amount,
        currency: currency,
      );

      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: true);
      } else {
        return StripeCustomResponse(ok: false, msg: 'Fallo: ${paymentResult.status}');
      }
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }
}
