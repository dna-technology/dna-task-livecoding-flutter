import 'package:dna_task_livecoding_flutter_payments/api/data/payment_request.dart';

class PaymentApiClient {
  Future<PaymentResponse> pay(final PaymentRequest paymentRequest) async {
    await Future.delayed(const Duration(milliseconds: 2500));

    if (paymentRequest.currency == "EUR" && paymentRequest.amount >= 20.00) {
      return PaymentResponse(
        transactionID: paymentRequest.transactionID,
        status: PaymentStatus.success,
      );
    } else {
      return PaymentResponse(
        transactionID: paymentRequest.transactionID,
        status: PaymentStatus.failed,
      );
    }
  }

  Future<PaymentResponse> revert(final PaymentRequest paymentRequest) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (paymentRequest.amount >= 1.00) {
      return PaymentResponse(
        transactionID: paymentRequest.transactionID,
        status: PaymentStatus.success,
      );
    } else {
      return PaymentResponse(
        transactionID: paymentRequest.transactionID,
        status: PaymentStatus.failed,
      );
    }
  }
}
