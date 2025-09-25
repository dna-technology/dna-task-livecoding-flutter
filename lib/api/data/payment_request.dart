class PaymentRequest {
  final String transactionID;
  final double amount;
  final String currency;
  final String cardToken;

  PaymentRequest({
    required this.transactionID,
    required this.amount,
    required this.currency,
    required this.cardToken,
  });
}

class PaymentResponse {
  final String transactionID;
  final PaymentStatus status;

  PaymentResponse({
    required this.transactionID,
    required this.status
  });
}

enum PaymentStatus { 
  success,
  failed
}
